import 'package:equatable/equatable.dart';
import 'package:problemator/models/problem.dart';
import 'package:problemator/models/route_sort_options.dart';
import 'package:problemator/models/visibility_filter.dart';

abstract class FilteredProblemsEvent extends Equatable {
  const FilteredProblemsEvent();
}

class UpdateFilter extends FilteredProblemsEvent {
  final VisibilityFilter filter;
  final List<int> selectedWalls;
  final RouteSortOption sort;

  const UpdateFilter({this.filter, this.selectedWalls, this.sort});

  @override
  List<Object> get props => [filter, selectedWalls, sort];

  @override
  String toString() => 'UpdateFilter { filter: $filter, walls: $selectedWalls , sort : $sort}';

  UpdateFilter copyWith({VisibilityFilter filter, List<int> selectedWalls, RouteSortOption sort}) {
    return UpdateFilter(
        filter: filter ?? this.filter,
        selectedWalls: selectedWalls ?? this.selectedWalls,
        sort: sort ?? this.sort);
  }
}

class UpdateProblems extends FilteredProblemsEvent {
  final List<Problem> problems;

  const UpdateProblems(this.problems);

  List<Object> get props => [problems];

  String toString() => 'UpdateProblems {problems: $problems}';
}
