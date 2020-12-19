import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:problemator/blocs/problems/problems.dart';
import 'package:problemator/models/problem.dart';
import 'package:problemator/models/route_sort_options.dart';
import 'package:problemator/models/visibility_filter.dart';

import 'filtered_problems_event.dart';
import 'filtered_problems_state.dart';

class FilteredProblemsBloc extends Bloc<FilteredProblemsEvent, FilteredProblemsState> {
  final ProblemsBloc _problemsBloc;

  //FilteredProblemsBloc(this._problemsBloc) : super(FilteredProblemsLoading());

  FilteredProblemsBloc({problemsBloc})
      : this._problemsBloc = problemsBloc,
        super(FilteredProblemsState(
            status: FilteredProblemsStatus.loading,
            activeFilter: VisibilityFilter.all,
            sort: RouteSortOption.tag_asc,
            selectedRouteAttributes: [],
            gradeFilters: [])) {
    _problemsBloc.listen((state) {
      if (state is ProblemsLoaded) {
        add(UpdateProblems((problemsBloc.state as ProblemsLoaded).problems));
      }
    });
  }

  @override
  Stream<FilteredProblemsState> mapEventToState(FilteredProblemsEvent event) async* {
    if (state.status == FilteredProblemsStatus.loaded && event is UpdateFilter) {
      yield* _mapUpdateFilterToState(state, event);
    } else if (event is UpdateProblems) {
      yield (state.copyWith(
          filteredProblems: event.problems, status: FilteredProblemsStatus.loaded));
    }
  }

  Stream<FilteredProblemsState> _mapUpdateFilterToState(
      FilteredProblemsState newState, UpdateFilter event) async* {
    // Apply filters to state. REMEMBER that the ORIGINAL set of problems is
    // being used. That's why we use _problemsBloc.state. Otherwise we
    // would end up with having an "AND" and ending up with zero problems.

    // Combine event filters with state filter, so that we have the whole
    // set of filters

    // As the route attribute filters can be toggled on and off they have to be
    // combined to the event. If the filter exists in the filters array, it
    // must be removed and if it doesn't, it must be added.
    final List<String> updatedAttributes = List.from(state.selectedRouteAttributes ?? []);
    if (event.selectedRouteAttributes != null && event.selectedRouteAttributes.length > 0) {
      event.selectedRouteAttributes.forEach((e) {
        if (updatedAttributes.contains(e)) {
          updatedAttributes.removeWhere((element) => element == e);
        } else {
          updatedAttributes.add(e);
        }
      });
    }
    // Do the same applying for (multiple) gradefilters
    final List<GradeSortScoreSpan> updatedGradeFilters = List.from(state.gradeFilters ?? []);
    if (event.gradeFilters != null && event.gradeFilters.length > 0) {
      event.gradeFilters.forEach((e) {
        if (updatedGradeFilters.contains(e)) {
          updatedGradeFilters.removeWhere((element) => element == e);
        } else {
          updatedGradeFilters.add(e);
        }
      });
    }

    UpdateFilter combinedFilter = event.copyWith(
      filter: event.filter ?? state.activeFilter,
      selectedWalls: event.selectedWalls ?? state.selectedWalls,
      sort: event.sort ?? state.sort,
      gradeFilters: updatedGradeFilters,
      selectedRouteAttributes: updatedAttributes,
    );

    yield (newState.copyWith(
        filteredProblems: _mapProblemsToFilteredProblems(
            (_problemsBloc.state as ProblemsLoaded).problems, combinedFilter),
        activeFilter: combinedFilter.filter,
        selectedWalls: combinedFilter.selectedWalls,
        sort: event.sort,
        selectedRouteAttributes: updatedAttributes,
        gradeFilters: updatedGradeFilters,
        status: FilteredProblemsStatus.loaded));
  }

  List<Problem> _mapProblemsToFilteredProblems(List<Problem> problems, UpdateFilter event) {
    // Here we can have a plethora of filters.
    VisibilityFilter filter = event.filter;
    List<int> selectedWalls = event.selectedWalls;
    RouteSortOption sort = event.sort;
    List<String> selectedRouteAttributes = event.selectedRouteAttributes;
    List<GradeSortScoreSpan> gradeFilters = event.gradeFilters;

    // This always returns a RESULT of the original filtered array.
    List<Problem> filteredProblems = problems.where((problem) {
      // Apply selectedWalls filter
      if (selectedWalls != null && selectedWalls.length > 0) {
        if (!selectedWalls.contains(int.tryParse(problem.wallid))) {
          return false;
        }
      }

      // Apply visiblityfilter
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.expiring) {
        return (problem.soonToBeRemoved == "1");
      } else if (filter == VisibilityFilter.circuits) {
        return (problem.partOfCircuit);
      } else if (filter == VisibilityFilter.fresh) {
        return (problem.fresh);
      } else if (filter == VisibilityFilter.project) {
        return problem.ticked == null;
      } else {
        return problem.ticked == null;
      }
    }).toList();

    // Apply selected route attributes
    filteredProblems = filteredProblems.where((problem) {
      if (selectedRouteAttributes != null && selectedRouteAttributes.length > 0) {
        List<String> attrs = problem.attributes.map((v) => v as String).toList();
        // Let's start with if amount of selectedRouteAttributes is MORE than
        // route attributes, we can safely assume that we cannot include the item.
        if (selectedRouteAttributes.length > attrs.length) {
          return false;
        }
        // Check that ALL of the selectedRouteAttributes are in the problems
        // attributes.
        bool allFound = true;
        selectedRouteAttributes.forEach((e) {
          if (!attrs.contains(e)) {
            allFound = false;
          }
        });
        return allFound;
      }
      // If no attributes are set, default showing all.
      return true;
    }).toList();

    // Apply gradefilters
    if (gradeFilters.length > 0) {
      filteredProblems = filteredProblems.where((problem) {
        return gradeFilters.where((gradeFilter) {
              if (problem.score >= gradeFilter.min && problem.score <= gradeFilter.max) {
                return true;
              }
              return false;
            }).length >
            0;
      }).toList();
    }

    // After filtering, do sorting.
    filteredProblems.sort((a, b) {
      switch (sort) {
        case RouteSortOption.least_ascents:
          return int.tryParse(a.ascentcount) - int.tryParse(b.ascentcount);
          break;
        case RouteSortOption.sectors_asc:
          return a.wallchar.compareTo(b.wallchar);
          break;
        case RouteSortOption.sectors_desc:
          return b.wallchar.compareTo(a.wallchar);
          break;
        case RouteSortOption.newest_first:
          return a.ageInDays - b.ageInDays;
          break;
        case RouteSortOption.newest_last:
          return b.ageInDays - a.ageInDays;
          break;
        case RouteSortOption.most_ascents:
          return int.tryParse(b.ascentcount) - int.tryParse(a.ascentcount);
          break;
        case RouteSortOption.least_ascents:
          return int.tryParse(a.ascentcount) - int.tryParse(b.ascentcount);
          break;
        case RouteSortOption.most_liked:
          return b.cLike - a.cLike;
          break;
        case RouteSortOption.least_liked:
          return a.cLike - b.cLike;
          break;
        case RouteSortOption.routesetter:
          return a.author.compareTo(b.author);
          break;
        case RouteSortOption.tag_asc:
          return a.tagshort.compareTo(b.tagshort);
          break;
        case RouteSortOption.tag_desc:
          return b.tagshort.compareTo(a.tagshort);
          break;
        case RouteSortOption.hardest_first:
          return (b.score) - (a.score);
          break;
        case RouteSortOption.hardest_last:
          return (a.score) - (b.score);
          break;
      }
      return 0;
    });
    return filteredProblems;
  }
}
