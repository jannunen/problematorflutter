import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:problemator/models/models.dart';

@immutable
abstract class ProblemsState extends Equatable {
  ProblemsState([List props = const []]) : super();
  @override
  List<Object> get props => [props];
}

class ProblemsLoading extends ProblemsState {
  @override
  String toString() => 'ProblemsLoading';
}


class ProblemsLoaded extends ProblemsState {
  final List<Problem> problems;

  ProblemsLoaded([this.problems = const []]) : super([problems]);

  @override
  String toString() => 'ProblemsLoaded { problems: $problems }';
}

class ProblemsNotLoaded extends ProblemsState {
  @override
  String toString() => 'ProblemsNotLoaded';
}
