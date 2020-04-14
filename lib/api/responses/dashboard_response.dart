import 'dart:collection';

import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:problemator/models/radarChart_data.dart';
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

class RadarChartResponse {
  RadarChartData radarChartData;

  RadarChartResponse.fromJson(Map<String, dynamic> json) {
  if (json != null) {
    radarChartData = new RadarChartData.fromJson(json);
    }
  }
}