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

  const FilteredProblemsLoaded(
    this.filteredProblems,
    this.activeFilter
  );

  @override
  List<Object> get props => [filteredProblems, activeFilter];

  @override
  String toString() => 'FilteredProblemsLoaded { filteredProblems: $filteredProblems, activeFilter: $activeFilter }';
}