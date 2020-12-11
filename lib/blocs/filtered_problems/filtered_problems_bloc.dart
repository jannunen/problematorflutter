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

  FilteredProblemsBloc(problemsBloc)
      : this._problemsBloc = problemsBloc,
        super(FilteredProblemsState(status: FilteredProblemsStatus.loading)) {
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
      //yield* _mapProblemsUpdatedToState(event);
    }
  }

  Stream<FilteredProblemsState> _mapUpdateFilterToState(
      FilteredProblemsState newState, UpdateFilter event) async* {
    // Apply filters to state
    newState.copyWith(
        filteredProblems: _mapProblemsToFilteredProblems(newState.filteredProblems, event),
        status: FilteredProblemsStatus.loaded);
    yield (newState);
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
    return problems.where((problem) {
      // Apply selectedWalls filter
      if (selectedWalls.length > 0 && !selectedWalls.contains(int.tryParse(problem.wallid))) {
        return false;
      }

      // Apply visiblityfilter
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.project) {
        return problem.ticked == null;
      } else {
        return problem.ticked == null;
      }
    }).toList();
  }
}
