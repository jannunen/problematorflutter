import 'package:problemator/components/api/ApiBaseHelper.dart';
import 'package:problemator/components/api/ProblemListResponse.dart';
import 'package:problemator/models/Problem.dart';

///
/// Class handles the actual data fetching from the API.
/// 
class ProblemRepository {
  final String _apiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1ODIyODUwMTYsImp0aSI6Ik5EUT0iLCJpc3MiOiJ3d3cucHJvYmxlbWF0b3IuZmkiLCJuYmYiOjE1ODIyODUwMTYsImV4cCI6MTU4NDg3NzAxNiwiZGF0YSI6eyJ1c2VySWQiOiIyNDYiLCJmaXJzdG5hbWUiOiJKYXJtbyIsImxhc3RuYW1lIjoiQW5udW5lbiIsImVtYWlsIjoiamFybW9AYW5udW5lbi5maSIsImd5bWlkIjoiMTEifX0.bFEKMgStrT_pBlvpOTSUauO5TSRNTa8S7_RQ2tsKrZ7C23nyg1HGF9LRX6HoUxrfQA9hEQ9gpkpgEkDtTY7Rgg";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Problem>> fetchProblemList() async {
    final response = await _helper.get("problemlist/?react=true&api-auth-token=$_apiKey");
    return ProblemListResponse.fromJson(response).problems;
  }
}