
import 'package:equatable/equatable.dart';
import 'package:problemator/blocs/dashboard_data/dashboard_data.dart';
import 'package:problemator/models/models.dart';
import 'package:problemator/models/radarChart_data.dart';


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
  final RadarChartData runningRadar;

  DashboardDataLoaded({ this.dashboard, this.runningChart, this.runningRadar}) : super();

  @override
  String toString() => 'DashboardLoaded { dashboard: $dashboard }';

  @override
  List<Object> get props => [dashboard,runningChart, runningRadar];

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
  String toString() => 'SixMonthLoaded { chartData: $chartData}';

  @override
  List<Object> get props => [chartData];

}

//Kun datan lataus epäonnistuu
class RunningSixMonthError extends DashboardDataState {
  @override
  String toString() => 'SixMonthDataNotLoaded';
}



class RunningRadarDataLoading extends DashboardDataState {
  @override 
  String toString() => 'RadarDataLoading';
 }

 class RunningRadarDataLoaded extends DashboardDataState {
    final RadarChartData radarData;

    RunningRadarDataLoaded({ this.radarData}) : super();

    @override 
    String toString() => 'SixMonthLoaded { radarData: $radarData}';

    @override
    List<Object> get props => [radarData];

}

//Kun datan lataus epäonnistuu
class RunningRadarDataError extends DashboardDataState {
  @override
  String toString() => 'RadarDataNotLoaded';
}

 