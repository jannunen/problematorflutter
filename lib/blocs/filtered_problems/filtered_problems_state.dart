import 'package:problemator/models/problem.dart';
import 'package:problemator/models/route_sort_options.dart';
import 'package:problemator/models/visibility_filter.dart';

import 'package:equatable/equatable.dart';

enum FilteredProblemsStatus { loading, loaded, error }

class FilteredProblemsState extends Equatable {
  final FilteredProblemsStatus status;
  final List<Problem> filteredProblems;
  final VisibilityFilter activeFilter;
  final List<int> selectedWalls;
  final RouteSortOption sort;

  const FilteredProblemsState(
      {this.status, this.filteredProblems, this.activeFilter, this.selectedWalls, this.sort});

  @override
  List<Object> get props => [filteredProblems, selectedWalls, activeFilter, status, sort];

  @override
  String toString() =>
      'FilteredProblemsLoaded { filteredProblems: $filteredProblems,  visibilityFilter : $activeFilter, selectedWalls : $selectedWalls, sort : $sort,status: $status}';

  FilteredProblemsState copyWith({
    List<Problem> filteredProblems,
    VisibilityFilter activeFilter,
    List<int> selectedWalls,
    FilteredProblemsStatus status,
    RouteSortOption sort,
  }) {
    return FilteredProblemsState(
      filteredProblems: filteredProblems ?? this.filteredProblems,
      activeFilter: activeFilter ?? this.activeFilter,
      selectedWalls: selectedWalls ?? this.selectedWalls,
      status: status ?? this.status,
      sort: sort ?? this.sort,
    );
  }
}
