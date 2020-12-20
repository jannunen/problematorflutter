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
  final List<String> selectedRouteAttributes;
  final List<GradeSortScoreSpan> gradeFilters;

  const UpdateFilter(
      {this.filter,
      this.selectedWalls,
      this.sort,
      this.selectedRouteAttributes,
      this.gradeFilters});

  @override
  List<Object> get props => [filter, selectedWalls, sort, selectedRouteAttributes, gradeFilters];

  @override
  String toString() =>
      'UpdateFilter { filter: $filter, walls: $selectedWalls , sort : $sort, selectedRouteAttributes: $selectedRouteAttributes}, gradeFilter: $gradeFilters';

  UpdateFilter copyWith({
    VisibilityFilter filter,
    List<int> selectedWalls,
    RouteSortOption sort,
    List<String> selectedRouteAttributes,
    List<GradeSortScoreSpan> gradeFilters,
  }) {
    return UpdateFilter(
      filter: filter ?? this.filter,
      selectedWalls: selectedWalls ?? this.selectedWalls,
      sort: sort ?? this.sort,
      selectedRouteAttributes: selectedRouteAttributes ?? this.selectedRouteAttributes,
      gradeFilters: gradeFilters ?? this.gradeFilters,
    );
  }
}

class UpdateProblems extends FilteredProblemsEvent {
  final List<Problem> problems;

  const UpdateProblems(this.problems);

  List<Object> get props => [problems];

  String toString() => 'UpdateProblems {problems: $problems}';
}

class ErrorLoadingProblems extends FilteredProblemsEvent {
  String error;
  ErrorLoadingProblems(this.error);

  @override
  List<Object> get props => [error];
}
