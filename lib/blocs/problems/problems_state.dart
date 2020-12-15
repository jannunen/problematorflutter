import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:problemator/models/models.dart';

@immutable
abstract class ProblemsState extends Equatable {
  ProblemsState([List props = const []]) : super();
}

class ProblemsLoading extends ProblemsState {
  @override
  String toString() => 'ProblemsLoading';

  @override
  List<Object> get props => ['ProblemsLoading'];
}

class ProblemsLoaded extends ProblemsState {
  final List<Problem> problems;
  final List<String> attributesInUse;

  ProblemsLoaded({this.attributesInUse = const [], this.problems = const []}) : super([problems]);

  @override
  String toString() => 'ProblemsLoaded { problems: $problems , attributesInUse: $attributesInUse}';
  @override
  List<Object> get props => [problems, attributesInUse];
}

class ProblemsNotLoaded extends ProblemsState {
  @override
  String toString() => 'ProblemsNotLoaded';
  @override
  List<Object> get props => ['ProblemsNotLoaded'];
}

class ProblemsErrorLoading extends ProblemsState {
  final String error;
  ProblemsErrorLoading(this.error);

  @override
  String toString() => 'ProblemsNotLoaded';
  @override
  List<Object> get props => [error];
}
