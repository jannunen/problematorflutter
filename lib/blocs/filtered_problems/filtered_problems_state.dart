import 'package:problemator/models/problem.dart';
import 'package:problemator/models/visibility_filter.dart';

import 'package:equatable/equatable.dart';

enum FilteredProblemsStatus { loading, loaded, error }

class FilteredProblemsState extends Equatable {
  final FilteredProblemsStatus status;
  final List<Problem> filteredProblems;
  final VisibilityFilter activeFilter;
  final List<int> selectedWalls;

  const FilteredProblemsState(
      {this.status, this.filteredProblems, this.activeFilter, this.selectedWalls});

  @override
  List<Object> get props => [filteredProblems, selectedWalls, activeFilter, status];

  @override
  String toString() =>
      'FilteredProblemsLoaded { filteredProblems: $filteredProblems,  visibilityFilter : $activeFilter, selectedWalls : $selectedWalls, status: $status}';

  FilteredProblemsState copyWith({
    List<Problem> filteredProblems,
    VisibilityFilter activeFilter,
    List<int> selectedWalls,
    FilteredProblemsStatus status,
  }) {
    return FilteredProblemsState(
      filteredProblems: filteredProblems ?? this.filteredProblems,
      activeFilter: activeFilter ?? this.activeFilter,
      selectedWalls: selectedWalls ?? this.selectedWalls,
      status: status ?? this.status,
    );
  }
}
