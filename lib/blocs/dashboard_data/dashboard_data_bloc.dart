import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:problemator/api/repository_api.dart';

import 'dashboard_data.dart';

class DashboardDataBloc extends Bloc<DashboardDataEvent, DashboardDataState> {
  // This is needed to communicate with the API
  final ProblemsRepository problemsRepository;

  DashboardDataBloc({@required this.problemsRepository}) : super(DashboardDataInitial());

  @override
  Stream<DashboardDataState> mapEventToState(DashboardDataEvent event) async* {
    if (event is LoadDashboardData) {
      yield* _mapLoadDashboardDataToState();
    }
  }

  Stream<DashboardDataState> _mapLoadDashboardDataToState() async* {
    yield DashboardDataLoading();
    try {
      final dashboard = await this.problemsRepository.fetchDashboard();
      yield DashboardDataLoaded(dashboard: dashboard);
    } catch (_) {
      yield DashboardDataNotLoaded();
    }
  }
}
