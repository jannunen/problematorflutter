
import 'package:equatable/equatable.dart';
import 'package:problemator/models/models.dart';

abstract class DashboardDataState extends Equatable {
  const DashboardDataState();
  @override
  List<Object> get props => [];
}

class DashboardDataInitial extends DashboardDataState {
}

class DashboardDataLoading extends DashboardDataState {
  @override
  String toString() => 'ProblemsLoading';
}

class DashboardDataLoaded extends DashboardDataState {
  final Dashboard dashboard;

  DashboardDataLoaded({ this.dashboard}) : super();

  @override
  String toString() => 'DashboardLoaded { dashboard: $dashboard }';

  @override
  List<Object> get props => [dashboard]; 
}

class DashboardDataNotLoaded extends DashboardDataState {
  @override
  String toString() => 'DashboardDataNotLoaded';
}