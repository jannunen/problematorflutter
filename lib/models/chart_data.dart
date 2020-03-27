
import 'dart:collection';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:problemator/api/responses/dashboard_response.dart';
import 'package:problemator/repository/repository.dart';
import 'package:problemator/repository/dashboard_entity.dart';


  
  class ChartDataPoint {
    HashMap<String, ChartDataPoint> chartPoint;
    String x;
    String a;
    String b;
 

    ChartDataPoint({
        this.x,
        this.a,
        this.b,
        
      });

    ChartDataPoint.fromJson(Map<String, dynamic> json) {
      chartPoint = new HashMap<String, ChartDataPoint>();
      json['points'].forEach((key, value) {
        chartPoint[value['x']] = ChartDataPoint(
            x : value['x'],
            a : value['a'],
            b : value['b']
            );
      });
  } 
}