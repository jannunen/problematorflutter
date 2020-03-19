import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './problems.dart';
import 'package:problemator/models/models.dart';
import 'package:problemator/api/repository_api.dart';

class ProblemsBloc extends Bloc<ProblemsEvent, ProblemsState> {
  final ProblemsRepositoryFlutter problemsRepository;

  ProblemsBloc({@required this.problemsRepository});

  @override
  ProblemsState get initialState => ProblemsLoading();

  @override
  Stream<ProblemsState> mapEventToState(ProblemsEvent event) async* {
    if (event is LoadProblems) {
      yield* _mapLoadProblemsToState();
    }     /* else if (event is UpdateProblem) {
      yield* _mapUpdateTodoToState(currentState, event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState(currentState);
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState(currentState);
    }
    */
  }

  Stream<ProblemsState> _mapLoadProblemsToState() async* {

    try {
      final problems = await this.problemsRepository.fetchProblems();
      yield ProblemsLoaded(
        problems.map(Problem.fromEntity).toList(),
      );
    } catch (_) {
      yield ProblemsNotLoaded();
    }
  }


/*


  Stream<ProblemsState> _mapUpdateTodoToState(
    ProblemsState currentState,
    UpdateProblem event,
  ) async* {
    if (currentState is ProblemsLoaded) {
      final List<Problem> updatedProblems = currentState.problems.map((todo) {
        return todo.id == event.updatedProblem.id ? event.updatedProblem : todo;
      }).toList();
      yield ProblemsLoaded(updatedProblems);
      _saveProblems(updatedProblems);
    }
  }


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
