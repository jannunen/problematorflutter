import 'dart:collection';
import 'package:equatable/equatable.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:meta/meta.dart';
import 'package:problemator/api/responses/dashboard_response.dart';
import 'package:problemator/repository/repository.dart';
import 'package:problemator/repository/dashboard_entity.dart';


class RadarChartData {
  List<RadarDataPoint> radarDataPoints;

  RadarChartData(radarDataPoints);

  RadarChartData.fromJson(Map<String, dynamic> json) {
    radarDataPoints = new List<RadarDataPoint>();
    json.forEach((key, value) {
      radarDataPoints.add( RadarDataPoint(days: value['days'], months: value['months'], allTime: value['allTime'] ));
    });
  }
}

class RadarDataPoint {
  String days;
  String months;
  String allTime;


  RadarDataPoint({
    this.days,
    this.months,
    this.allTime
  });
}