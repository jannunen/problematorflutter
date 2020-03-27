import 'dart:collection';

import 'package:problemator/models/chart_data.dart';
import 'package:problemator/repository/dashboard_entity.dart';
import 'package:problemator/repository/problem_entity.dart';

class DashboardResponse {
  DashboardEntity dashboard;

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      dashboard = new DashboardEntity.fromJson(json);
    }
  }
}

class ChartDataResponse {
  ChartData chartData;

  ChartDataResponse.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      chartData = new ChartData.fromJson(json);
    }
  }
}