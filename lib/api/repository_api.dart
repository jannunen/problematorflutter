import 'package:problemator/api/ApiBaseHelper.dart';
import 'package:problemator/api/responses/responses.dart';

import 'package:problemator/repository/repository.dart';

///
/// Class handles the actual data fetching from the API.
/// 
class ProblemsRepositoryFlutter implements ProblemListRepository , ProblemRepository {
  final String _apiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1ODIzOTgzNDEsImp0aSI6Ik16ST0iLCJpc3MiOiJ3d3cucHJvYmxlbWF0b3IuZmkiLCJuYmYiOjE1ODIzOTgzNDEsImV4cCI6MTU4NDk5MDM0MSwiZGF0YSI6eyJ1c2VySWQiOiIyNDYiLCJmaXJzdG5hbWUiOiJKYXJtbyIsImxhc3RuYW1lIjoiQW5udW5lbiIsImVtYWlsIjoiamFybW9AYW5udW5lbi5maSIsImd5bWlkIjoiMTEifX0.9m_QAr96ZiTHWT4lph1EaGzBejvsbt56oBaf3MCrDaHlyoTmvIb4jDfaFDtkKEKRUrcNmnqRFlIgHGoSyMr-qA";

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
    print("Ourrait, got "+response.toString());
    DashboardEntity d =  DashboardResponse.fromJson(response).dashboard;
    return d;
  }



}