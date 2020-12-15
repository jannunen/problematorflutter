import 'package:equatable/equatable.dart';
import 'package:problemator/models/problem.dart';
import 'package:problemator/models/visibility_filter.dart';

abstract class FilteredProblemsEvent extends Equatable {
  const FilteredProblemsEvent();
}

class UpdateFilter extends FilteredProblemsEvent {
  final VisibilityFilter filter;
  final List<int> selectedWalls;
  const UpdateFilter({this.filter, this.selectedWalls});

  @override
  List<Object> get props => [filter, selectedWalls];

  @override
  String toString() => 'UpdateFilter { filter: $filter, $selectedWalls }';

  UpdateFilter copyWith({VisibilityFilter filter, List<int> selectedWalls}) {
    return UpdateFilter(
        filter: filter ?? this.filter, selectedWalls: selectedWalls ?? this.selectedWalls);
  }
}

class UpdateProblems extends FilteredProblemsEvent {
  final List<Problem> problems;

  const UpdateProblems(this.problems);

  List<Object> get props => [problems];

  String toString() => 'UpdateProblems {problems: $problems}';
}
