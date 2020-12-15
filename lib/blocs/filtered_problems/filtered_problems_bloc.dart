import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:problemator/blocs/problems/problems.dart';
import 'package:problemator/models/problem.dart';
import 'package:problemator/models/visibility_filter.dart';

import 'filtered_problems_event.dart';
import 'filtered_problems_state.dart';

class FilteredProblemsBloc extends Bloc<FilteredProblemsEvent, FilteredProblemsState> {
  final ProblemsBloc _problemsBloc;

  //FilteredProblemsBloc(this._problemsBloc) : super(FilteredProblemsLoading());

  FilteredProblemsBloc({problemsBloc})
      : this._problemsBloc = problemsBloc,
        super(FilteredProblemsState(
            status: FilteredProblemsStatus.loading, activeFilter: VisibilityFilter.all)) {
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
        selectedWalls: event.selectedWalls ?? state.selectedWalls);
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
    // This always returns a RESULT of the original filtered array.
    return problems.where((problem) {
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
  }
}
