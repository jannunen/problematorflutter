import 'package:problemator/models/problem.dart';
import 'package:problemator/models/visibility_filter.dart';

import 'package:equatable/equatable.dart';

abstract class FilteredProblemsState extends Equatable {
  const FilteredProblemsState();
  @override
  List<Object> get props => [];
}

class FilteredProblemsLoading extends FilteredProblemsState {}

class FilteredProblemsLoaded extends FilteredProblemsState {
  final List<Problem> filteredProblems;
  final VisibilityFilter activeFilter;
  final List<int> selectedWalls;

  const FilteredProblemsLoaded({this.filteredProblems, this.activeFilter, this.selectedWalls});

  @override
  List<Object> get props => [filteredProblems, selectedWalls, activeFilter];

  @override
  String toString() =>
      'FilteredProblemsLoaded { filteredProblems: $filteredProblems,  visibilityFilter : $activeFilter, selectedWalls : $selectedWalls}';

  FilteredProblemsLoaded copyWith({
    List<Problem> filteredProblems,
    VisibilityFilter activeFilter,
    List<int> selectedWalls,
  }) {
    return FilteredProblemsLoaded(
      filteredProblems: filteredProblems ?? this.filteredProblems,
      activeFilter: activeFilter ?? this.activeFilter,
      selectedWalls: selectedWalls ?? this.selectedWalls,
    );
  }
}
