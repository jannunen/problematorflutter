import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProblemsEvent extends Equatable {
  ProblemsEvent([List props = const []]) : super();

  @override
  List<Object> get props => [props];
}

class LoadProblems extends ProblemsEvent {
  @override
  String toString() => 'LoadProblems';
}

/*
class UpdateProblem extends ProblemsEvent {
  final Problem updatedProblem;

  UpdateProblem(this.updatedProblem) : super([updatedProblem]);

  @override
  String toString() => 'UpdateProblem { updatedProblem: $updatedProblem }';
}
*/

class ClearCompleted extends ProblemsEvent {
  @override
  String toString() => 'ClearCompleted';
}

class ToggleAll extends ProblemsEvent {
  @override
  String toString() => 'ToggleAll';
}
