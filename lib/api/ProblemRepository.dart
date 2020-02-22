import 'package:problemator/api/ApiBaseHelper.dart';
import 'package:problemator/api/responses/ProblemListResponse.dart';
import 'package:problemator/api/responses/ProblemDetailsResponse.dart';
import 'package:problemator/models/Problem.dart';

///
/// Class handles the actual data fetching from the API.
/// 
class ProblemRepository {
  final String _apiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1ODIzOTgzNDEsImp0aSI6Ik16ST0iLCJpc3MiOiJ3d3cucHJvYmxlbWF0b3IuZmkiLCJuYmYiOjE1ODIzOTgzNDEsImV4cCI6MTU4NDk5MDM0MSwiZGF0YSI6eyJ1c2VySWQiOiIyNDYiLCJmaXJzdG5hbWUiOiJKYXJtbyIsImxhc3RuYW1lIjoiQW5udW5lbiIsImVtYWlsIjoiamFybW9AYW5udW5lbi5maSIsImd5bWlkIjoiMTEifX0.9m_QAr96ZiTHWT4lph1EaGzBejvsbt56oBaf3MCrDaHlyoTmvIb4jDfaFDtkKEKRUrcNmnqRFlIgHGoSyMr-qA";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Problem>> fetchProblemList() async {
    final response = await _helper.get("problemlist/?react=true&api-auth-token=$_apiKey");
    return ProblemListResponse.fromJson(response).problems;
  }

  Future<Problem> fetchProblemDetails(String problemid) async {
    final response = await _helper.get("problem/"+problemid+"?react=true&api-auth-token=$_apiKey");
    Problem p =  ProblemDetailsResponse.fromJson(response['problem']).problem;
    return p;
  }

}