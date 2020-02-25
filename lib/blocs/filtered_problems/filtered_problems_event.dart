import 'package:equatable/equatable.dart';
import 'package:problemator/models/problem.dart';
import 'package:problemator/models/visibility_filter.dart';


abstract class FilteredProblemsEvent extends Equatable {
  const FilteredProblemsEvent();
}

class UpdateFilter extends FilteredProblemsEvent {
  final VisibilityFilter filter;
  const UpdateFilter(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'UpdateFilter { filter: $filter }';
}

class UpdateProblems extends FilteredProblemsEvent {
  final List<Problem> problems;

  const UpdateProblems(this.problems);

  List<Object> get props => [problems];

  String toString() => 'UpdateProblems {problems: $problems}';
}
