import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:problemator/blocs/filtered_problems/filtered_problems.dart';
import 'package:problemator/blocs/problems/problems.dart';
import 'package:problemator/models/problem.dart';
import 'package:problemator/models/visibility_filter.dart';

import 'filtered_problems_event.dart';
import 'filtered_problems_state.dart';

class FilteredProblemsBloc extends Bloc<FilteredProblemsEvent, FilteredProblemsState> {
  final ProblemsBloc problemsBloc;
  StreamSubscription problemsSubscription;

  FilteredProblemsBloc({@required this.problemsBloc})
      : super(problemsBloc.state is ProblemsLoaded
            ? FilteredProblemsLoaded(
                filteredProblems: (problemsBloc.state as ProblemsLoaded).problems,
                activeFilter: VisibilityFilter.all,
              )
            : FilteredProblemsLoading()) {
    problemsSubscription = problemsBloc.listen((state) {
      if (state is ProblemsLoaded) {
        add(UpdateProblems((problemsBloc.state as ProblemsLoaded).problems));
      }
    });
  }

  @override
  Stream<FilteredProblemsState> mapEventToState(FilteredProblemsEvent event) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(state as FilteredProblemsLoaded, event);
    } else if (event is UpdateProblems) {
      yield ((state as FilteredProblemsLoaded).copyWith(filteredProblems: event.problems));
      //yield* _mapProblemsUpdatedToState(event);
    }
  }

  Stream<FilteredProblemsState> _mapUpdateFilterToState(
      FilteredProblemsLoaded newState, UpdateFilter event) async* {
    if (problemsBloc.state is ProblemsLoaded) {
      // Apply filters to state
      newState.copyWith(
          filteredProblems: _mapProblemsToFilteredProblems(newState.filteredProblems, event));
      yield (newState);
    }
  }

  Stream<FilteredProblemsState> _mapProblemsUpdatedToState(
    UpdateProblems event,
  ) async* {
    // final visibilityFilter = state is FilteredProblemsLoaded
    //     ? (state as FilteredProblemsLoaded).activeFilter
    //     : VisibilityFilter.all;
  }

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

  @override
  Future<void> close() {
    problemsSubscription.cancel();
    return super.close();
  }
}
