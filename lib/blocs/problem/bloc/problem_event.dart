part of 'problem_bloc.dart';

abstract class ProblemEvent extends Equatable {
  const ProblemEvent();
}

class LoadProblemExtraInfo extends ProblemEvent {
  final String id;
  LoadProblemExtraInfo(this.id);

  @override
  String toString() => 'LoadProblemExtraInfo';

  @override
  List<Object> get props => [id];
}

class AddTick extends ProblemEvent {
  final Tick tick;
  AddTick({this.tick});

  @override
  List<Object> get props => ['tick'];
}
class LikeProblem extends ProblemEvent {
  final Problem problem;
  LikeProblem(this.problem);

  @override
  List<Object> get props => [problem];
}