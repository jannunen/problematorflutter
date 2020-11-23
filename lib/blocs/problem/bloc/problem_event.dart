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
