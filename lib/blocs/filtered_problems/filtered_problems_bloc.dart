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
            sort: RouteSortOption.tag_asc)) {
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
    UpdateFilter combinedFilter = event.copyWith(
        filter: event.filter ?? state.activeFilter,
        selectedWalls: event.selectedWalls ?? state.selectedWalls,
        sort: event.sort ?? state.sort);

    yield (newState.copyWith(
        filteredProblems: _mapProblemsToFilteredProblems(
            (_problemsBloc.state as ProblemsLoaded).problems, combinedFilter),
        activeFilter: combinedFilter.filter,
        selectedWalls: combinedFilter.selectedWalls,
        status: FilteredProblemsStatus.loaded));
  }
  /*

  Stream<FilteredProblemsState> _mapProblemsUpdatedToState(
    UpdateProblems event,
  ) async* {
    // final visibilityFilter = state is FilteredProblemsLoaded
    //     ? (state as FilteredProblemsLoaded).activeFilter
    //     : VisibilityFilter.all;
  }
  */

  List<Problem> _mapProblemsToFilteredProblems(List<Problem> problems, UpdateFilter event) {
    // Here we can have a plethora of filters.
    VisibilityFilter filter = event.filter;
    List<int> selectedWalls = event.selectedWalls;
    RouteSortOption sort = event.sort;
    // This always returns a RESULT of the original filtered array.
    final List<Problem> filteredProblems = problems.where((problem) {
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
          return int.tryParse(a.ageInWeeks) - int.tryParse(b.ageInWeeks);
          break;
        case RouteSortOption.newest_last:
          return int.tryParse(b.ageInWeeks) - int.tryParse(a.ageInWeeks);
          break;
        case RouteSortOption.most_ascents:
          return int.tryParse(b.ascentcount) - int.tryParse(a.ascentcount);
          break;
        case RouteSortOption.least_ascents:
          return int.tryParse(a.ascentcount) - int.tryParse(b.ascentcount);
          break;
        case RouteSortOption.most_liked:
          return a.cLike - b.cLike;
          break;
        case RouteSortOption.least_liked:
          return b.cLike - a.cLike;
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
      }
      return 0;
    });
    return filteredProblems;
  }
}
