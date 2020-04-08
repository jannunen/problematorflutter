import 'dart:collection';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:problemator/api/responses/dashboard_response.dart';
import 'package:problemator/repository/repository.dart';
import 'package:problemator/repository/dashboard_entity.dart';

class ChartData {
  List<ChartDataPoint> dataPoints;

  ChartData(dataPoints);

  ChartData.fromJson(Map<String, dynamic> json) {
    dataPoints = new List<ChartDataPoint>();
    json.forEach((key, value) {
      dataPoints.add( ChartDataPoint(y: value['y'], a: value['a'], b: value['b']));
    });
  }
}

class ChartDataPoint {
  String y;
  String a; // should be double
  String b; // should be double

  ChartDataPoint({
    this.y,
    this.a,
    this.b,
  });

}
