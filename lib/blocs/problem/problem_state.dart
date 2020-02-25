import 'package:equatable/equatable.dart';

abstract class ProblemState extends Equatable {
  const ProblemState();
}

class ProblemInitial extends ProblemState {
  @override
  List<Object> get props => [];
}
