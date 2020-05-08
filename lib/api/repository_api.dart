import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:problemator/api/ApiBaseHelper.dart';
import 'package:problemator/api/responses/responses.dart';
import 'package:problemator/models/chart_data.dart';
import 'package:problemator/models/radarChart_data.dart';

import 'package:problemator/repository/repository.dart';

///
/// Class handles the actual data fetching from the API.
/// 
class ProblemsRepositoryFlutter implements ProblemListRepository , ProblemRepository {
  final String _apiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1ODc0ODE0MTAsImp0aSI6Ik5UUT0iLCJpc3MiOiJ3d3cucHJvYmxlbWF0b3IuZmkiLCJuYmYiOjE1ODc0ODE0MTAsImV4cCI6MTU5MDA3MzQxMCwiZGF0YSI6eyJ1c2VySWQiOiI2Njc5MyIsImZpcnN0bmFtZSI6IlRvbWkgIiwibGFzdG5hbWUiOiJTYWxvIiwiZW1haWwiOiJ0b21pLmEuc2Fsb0BvdXRsb29rLmNvbSIsImd5bWlkIjoiMSJ9fQ.9D8Gctn8z3QW-qtcEotjm4skmldmx0NJanrXAmz-EtBPMjIbN_-4RTXrA1KQW4c1ZeJW05GHCzubonjAtUjX8w";

  //final String _apiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1ODIzOTgzNDEsImp0aSI6Ik16ST0iLCJpc3MiOiJ3d3cucHJvYmxlbWF0b3IuZmkiLCJuYmYiOjE1ODIzOTgzNDEsImV4cCI6MTU4NDk5MDM0MSwiZGF0YSI6eyJ1c2VySWQiOiIyNDYiLCJmaXJzdG5hbWUiOiJKYXJtbyIsImxhc3RuYW1lIjoiQW5udW5lbiIsImVtYWlsIjoiamFybW9AYW5udW5lbi5maSIsImd5bWlkIjoiMTEifX0.9m_QAr96ZiTHWT4lph1EaGzBejvsbt56oBaf3MCrDaHlyoTmvIb4jDfaFDtkKEKRUrcNmnqRFlIgHGoSyMr-qA";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<ProblemEntity>> fetchProblems() async {
    final response = await _helper.get("problemlist/?react=true&api-auth-token=$_apiKey");
    return ProblemListResponse.fromJson(response).problems;
  }

  Future<ProblemEntity> fetchProblemDetails(String problemid) async {
    final response = await _helper.get("problem/"+problemid+"?react=true&api-auth-token=$_apiKey");
    ProblemEntity p =  ProblemDetailsResponse.fromJson(response['problem']).problem;
    return p;
  }
  Future<DashboardEntity> fetchDashboard() async {
    final response = await _helper.get("dashinfo/?react=true&api-auth-token=$_apiKey");
    DashboardEntity d =  DashboardResponse.fromJson(response).dashboard;
    return d;
  }

  Future<ChartData> fetchRunningChartData() async {
    final response = await _helper.get("json_running6mo_both/?react=true&api-auth-token=$_apiKey");
    ChartData d = ChartDataResponse.fromJson(response).chartData;
    return d;
  }

  Future<RadarChartData> fetchRunningRadarData() async {
    final response = await _helper.get("radarchart/?react=true&api-auth-token=$_apiKey");
    RadarChartData d = RadarChartResponse.fromJson(response).radarChartData;
    return d;

  }


}