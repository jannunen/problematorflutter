
import 'package:equatable/equatable.dart';

abstract class ProblemEvent extends Equatable {
  const ProblemEvent();
}

class LoadProblem extends ProblemEvent {
  @override
  String toString() => 'LoadProblem';

  @override
  List<Object> get props => ['LoadProblem'];
}
