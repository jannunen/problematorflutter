import 'dart:collection';
import 'package:equatable/equatable.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:meta/meta.dart';
import 'package:problemator/api/responses/dashboard_response.dart';
import 'package:problemator/repository/repository.dart';
import 'package:problemator/repository/dashboard_entity.dart';


class RadarChartData {
  List<String> labels;
  List<RadarChartDataSet> datasets;

  RadarChartData(datasets, labels);

  RadarChartData.fromJson(Map<String, dynamic> json) {
    labels = new List();
    datasets = new List<RadarChartDataSet>();
    

    json.forEach((key, value) {
      if (key == 'labels') {
        value.forEach((value) {
          labels.add((value));          
        });
      } 
    }); 
  
    json.forEach((key, value) {
      if(key == 'datasets') {
        for(var item in value) {
         //item.forEach((item) {
           datasets.add(RadarChartDataSet.fromJson(item));
           
                       
          //});
        }
    }});     
  }
}
           
           
           
class RadarChartDataSet {
  String label;
  String backgroundColor;
  String borderColor;
  String borderWidth;
  String pointBackgroundColor;
  String pointBorderColor;
  String pointHoverBackgroundColor;
  String pointHoverBorderColor;
  List <int> data;
           
  RadarChartDataSet({
    this.label,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.pointBackgroundColor,
    this.pointBorderColor,
    this.pointHoverBackgroundColor,
    this.pointHoverBorderColor,
    this.data,
  });
           
  RadarChartDataSet.fromJson(Map<String, dynamic> json) {
    int i = 1;
    this.label = json['label'];
    this.borderColor = json['borderColor'];
  }
}
/*
  @override
    List<Object> get props => [label, backgroundColor, borderWidth, data];


  RadarChartDataSet copyWith({
    label, 
    backgroundColor, 
    borderWidth,
    data
  }) {
    return RadarChartDataSet(
      label: label,
      backgroundColor: backgroundColor,
      borderWidth: borderWidth,
      data: data
      ); 
  }
}
label: value['label'],
           backgroundColor: value['backgroundcolor'], borderColor: value['borderColor'], borderWidth: value['borderwidth'],
           pointBackgroundColor: value['pointBackgroundColor'], pointBorderColor: value['pointBorderColor'], 
           pointHoverBackgroundColor: value['pointHoverBackgroundColor:'], pointHoverBorderColor: value['pointHoverBorderColor'], data: value['data']));
      

      for(var listat in value) {
          for(var item in listat) {
            
          } 
        } 
*/
