
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
  final ChartData runningChart;

  DashboardDataLoaded({ this.dashboard, this.runningChart}) : super();

  @override
  String toString() => 'DashboardLoaded { dashboard: $dashboard }';

  @override
  List<Object> get props => [dashboard,runningChart]; 
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
  final ChartData chartData;

  RunningSixMonthLoaded({ this.chartData}) : super();

  @override 
  String toString() => 'SixMonthLoaded { chartData: $chartData }';

  @override
  List<Object> get props => [chartData];
}

//Kun datan lataus epäonnistuu
class RunningSixMonthError extends DashboardDataState {
  @override
  String toString() => 'SixMonthDataNotLoaded';
}