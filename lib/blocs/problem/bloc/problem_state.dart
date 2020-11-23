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

class TickAdded extends ProblemState {
  final Tick addedTick;
  TickAdded({this.addedTick});
  @override
  List<Object> get props => [addedTick];
}
