import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:problemator/blocs/problem/bloc/problem_bloc.dart';
import 'package:problemator/models/problem.dart';
import './problems.dart';
import 'package:problemator/api/repository_api.dart';

class ProblemsBloc extends Bloc<ProblemsEvent, ProblemsState> {
  final ProblemsRepository problemsRepository;
  final ProblemBloc _problemBloc;

  ProblemsBloc({@required this.problemsRepository, problemBloc})
      : this._problemBloc = problemBloc,
        super(ProblemsNotLoaded()) {
    _problemBloc.listen((state) {
      if (state is TickAdded) {
        add(UpdateProblem(state.problem));
      }
    });
  }

  @override
  Stream<ProblemsState> mapEventToState(ProblemsEvent event) async* {
    if (event is LoadProblems) {
      yield* _mapLoadProblemsToState();
    } else if (event is UpdateProblem) {
      yield* _mapUpdateTodoToState(state, event);
    }
    /* else if (event is ToggleAll) {
      yield* _mapToggleAllToState(currentState);
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState(currentState);
    }
    */
  }

  Stream<ProblemsState> _mapLoadProblemsToState() async* {
    try {
      final problemList = await this.problemsRepository.fetchProblems();
      if (problemList != null) {
        yield ProblemsLoaded(problemList.problems);
      } else {
        yield ProblemsErrorLoading("Probably not logged in");
      }
    } catch (_) {
      yield ProblemsNotLoaded();
    }
  }

  Stream<ProblemsState> _mapUpdateTodoToState(
    ProblemsState currentState,
    UpdateProblem event,
  ) async* {
    if (currentState is ProblemsLoaded) {
      final List<Problem> updatedProblems = currentState.problems.map((todo) {
        return todo.id == event.problem.id ? event.problem : todo;
      }).toList();
      yield ProblemsLoaded(updatedProblems);
    }
  }
/*


  Stream<ProblemsState> _mapToggleAllToState(ProblemsState currentState) async* {
    if (currentState is ProblemsLoaded) {
      final allComplete = currentState.problems.every((problem) => problem.complete);
      final List<Problem> updatedProblems = currentState.problems
          .map((problem) => problem.copyWith(complete: !allComplete))
          .toList();
      yield ProblemsLoaded(updatedProblems);
      _saveProblems(updatedProblems);
    }
  }

  Stream<ProblemsState> _mapClearCompletedToState(ProblemsState currentState) async* {
    if (currentState is ProblemsLoaded) {
      final List<Problem> updatedProblems =
          currentState.problems.where((todo) => !todo.complete).toList();
      yield ProblemsLoaded(updatedProblems);
      _saveProblems(updatedProblems);
    }
  }

  Future _saveProblems(List<Problem> problems) {
    return problemsRepository.saveProblems(
      problems.map((todo) => todo.toEntity()).toList(),
    );
  }
  */
}
