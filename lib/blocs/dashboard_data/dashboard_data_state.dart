
import 'package:equatable/equatable.dart';
import 'package:problemator/blocs/dashboard_data/dashboard_data.dart';
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


//Datan latausvaihe 
class RunningSixMonthLoading extends DashboardDataState {
  @override
  String toString() => 'SixMonthProblemsLoading';
}

//Onnistunut datan lataus
class RunningSixMonthLoaded extends DashboardDataState {
  final Dashboard dashboard;

  RunningSixMonthLoaded({ this.dashboard}) : super();

  @override 
  String toString() => 'SixMonthLoaded { dashboard: $dashboard }';

  @override
  List<Object> get props => [dashboard];
}

//Kun datan lataus epäonnistuu
class RunningSixMonthError extends DashboardDataState {
  @override
  String toString() => 'SixMonthDataNotLoaded';
}