import 'package:problemator/api/ApiBaseHelper.dart';
import 'package:problemator/api/responses/responses.dart';
import 'package:problemator/models/chart_data.dart';

import 'package:problemator/repository/repository.dart';

///
/// Class handles the actual data fetching from the API.
/// 
class ProblemsRepositoryFlutter implements ProblemListRepository , ProblemRepository {
  final String _apiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1ODQ0NjIwNzMsImp0aSI6Ik5qQT0iLCJpc3MiOiJ3d3cucHJvYmxlbWF0b3IuZmkiLCJuYmYiOjE1ODQ0NjIwNzMsImV4cCI6MTU4NzA1NDA3MywiZGF0YSI6eyJ1c2VySWQiOiI2Njc5MyIsImZpcnN0bmFtZSI6IlRvbWkgIiwibGFzdG5hbWUiOiJTYWxvIiwiZW1haWwiOiJ0b21pLmEuc2Fsb0BvdXRsb29rLmNvbSIsImd5bWlkIjoiMSJ9fQ.HpaMUFSrNKzgtzgxvhOmcpKkCV1c-HbCd9UN4XDA7lxjfkl-c4ZC2NmcM8EcWKR_-fp0k5sMRP3ZYuwNxKnUoQ";

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



}