import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:problemator/api/repository_api.dart';
import 'package:problemator/models/models.dart';
import 'package:problemator/models/chart_data.dart';
import 'dashboard_data.dart';

class DashboardDataBloc extends Bloc<DashboardDataEvent, DashboardDataState> {
  // This is needed to communicate with the API
  final ProblemsRepositoryFlutter problemsRepository;

  DashboardDataBloc({@required this.problemsRepository});

  @override
  DashboardDataState get initialState => DashboardDataLoading();

  
  @override
  Stream<DashboardDataState> mapEventToState( DashboardDataEvent event) async* {
    if (event is LoadDashboardData) {
      yield* _mapLoadDashboardDataToState();
    }
  }


  Stream<DashboardDataState> _mapLoadDashboardDataToState()  async* {
    yield DashboardDataLoading();
    yield RunningSixMonthLoading();
    try {
      final data = await this.problemsRepository.fetchDashboard();
      yield DashboardDataLoaded( dashboard : Dashboard.fromEntity(data));
      
      
    }
    catch(_) {
      yield DashboardDataNotLoaded();
    }

    
    try {
      final sixMonthData = await this.problemsRepository.fetchRunningChartData();
      yield RunningSixMonthLoaded(charDataPoint: ChartDataPoint.fromJson(sixMonthData));
    }
    catch(_) {
      yield RunningSixMonthError();
    }
    }

  }

class ChartDataBloc extends Bloc<DashboardDataEvent, ChartDataPoint> {
  // This is needed to communicate with the API
  final ProblemsRepositoryFlutter problemsRepository;

  ChartDataBloc({@required this.problemsRepository});

  @override
  ChartDataPoint get initialState => RunningSixMonthLoading();

  @override
  Stream<ChartDataPoint> mapEventToState( DashboardDataEvent event) async* {
    if (event is LoadDashboardData) {
      yield* _mapLoadDashboardDataToState();
    }
  }

  Stream<DashboardDataState> _mapLoadDashboardDataToState() async* {
    yield RunningSixMonthLoading();
    try {
      final data = await this.problemsRepository.fetchDashboard();
      yield RunningSixMonthLoaded(dashboard: Dashboard.fromEntity(data));
    }
    catch(_) {
      yield RunningSixMonthError();
    }
  }

}