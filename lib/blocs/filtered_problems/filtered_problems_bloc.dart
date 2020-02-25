import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:problemator/blocs/filtered_problems/filtered_problems.dart';
import 'package:problemator/blocs/problems/problems.dart';
import 'package:problemator/models/problem.dart';
import 'package:problemator/models/visibility_filter.dart';

import 'filtered_problems_event.dart';
import 'filtered_problems_state.dart';

class FilteredProblemsBloc
    extends Bloc<FilteredProblemsEvent, FilteredProblemsState> {
  final ProblemsBloc problemsBloc;
  StreamSubscription problemsSubscription;

  FilteredProblemsBloc({@required this.problemsBloc}) {
    problemsSubscription = problemsBloc.listen((state) {
      if (state is ProblemsLoaded) {
        add(UpdateProblems((problemsBloc.state as ProblemsLoaded).problems));
      }
    });
  }

  @override
  FilteredProblemsState get initialState {
    return problemsBloc.state is ProblemsLoaded
        ? FilteredProblemsLoaded(
            (problemsBloc.state as ProblemsLoaded).problems,
            VisibilityFilter.all,
          )
        : FilteredProblemsLoading();
  }

  @override
  Stream<FilteredProblemsState> mapEventToState( FilteredProblemsEvent event) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is UpdateProblems) {
      yield* _mapProblemsUpdatedToState(event);
    }
  }

  Stream<FilteredProblemsState> _mapUpdateFilterToState(
      UpdateFilter event) async* {
    if (problemsBloc.state is ProblemsLoaded) {
      yield FilteredProblemsLoaded(
        _mapProblemsToFilteredProblems(
          (problemsBloc.state as ProblemsLoaded).problems,
          event.filter,
        ),
        event.filter,
      );
    }
  }

  Stream<FilteredProblemsState> _mapProblemsUpdatedToState(
    UpdateProblems event,
  ) async* {
    final visibilityFilter = state is FilteredProblemsLoaded
        ? (state as FilteredProblemsLoaded).activeFilter
        : VisibilityFilter.all;
    yield FilteredProblemsLoaded(
      _mapProblemsToFilteredProblems(
        (problemsBloc.state as ProblemsLoaded).problems,
        visibilityFilter,
      ),
      visibilityFilter,
    );
  }

  List<Problem> _mapProblemsToFilteredProblems(
      List<Problem> problems, VisibilityFilter filter) {
    return problems.where((problem) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.project) {
        return problem.ticked == null;
      } else {
        return problem.ticked == null ;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    problemsSubscription.cancel();
    return super.close();
  }

}
