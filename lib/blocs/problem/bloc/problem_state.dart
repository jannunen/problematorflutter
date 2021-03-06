part of 'problem_bloc.dart';

abstract class ProblemState extends Equatable {
  const ProblemState();
}

class ProblemInitial extends ProblemState {
  @override
  List<Object> get props => [];
}

class ProblemExtraInfoLoading extends ProblemState {
  @override
  List<Object> get props => ['loading'];
}

class ProblemExtraInfoLoaded extends ProblemState {
  final ProblemExtraInfo problemExtraInfo;
  ProblemExtraInfoLoaded({this.problemExtraInfo});
  @override
  List<Object> get props => [problemExtraInfo];
}

class AddingTick extends ProblemState {
  @override
  List<Object> get props => ['AddingTick'];
}

class TickAdded extends ProblemExtraInfoLoaded {
  final Tick addedTick;
  final Problem problem;
  final ProblemExtraInfo problemExtraInfo;
  TickAdded({this.addedTick, this.problemExtraInfo, this.problem});
  @override
  List<Object> get props => [addedTick];
}

class TickAddFailed extends ProblemExtraInfoLoaded {
  final String error;
  final ProblemExtraInfo problemExtraInfo;
  TickAddFailed(this.error, this.problemExtraInfo);

  @override
  List<Object> get props => [error];
}

class LikingProblem extends ProblemState {
  @override
  List<Object> get props => ['LikingProblem'];
}

class LikedProblem extends ProblemState{
  final Problem problem;
  LikedProblem({this.problem});
  @override
  List<Object> get props => ['addedLike'];
}

class LikeProblemFailed extends ProblemState {
  final String error;
  LikeProblemFailed(this.error);

  @override
  List<Object> get props => [error];
}
