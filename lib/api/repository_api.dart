import 'package:problemator/api/api_client.dart';
import 'package:problemator/models/models.dart';

///
/// Class handles the actual data fetching from the API.
///
class ProblemsRepository {
  final ApiClient _apiClient = ApiClient();

  Future<ProblemList> fetchProblems() async {
    return await _apiClient.getProblemList();
  }

  Future<Problem> fetchProblemDetails(String problemid) async {
    return await _apiClient.fetchProblemDetails(problemid);
  }

  Future<Dashboard> fetchDashboard() async {
    return await _apiClient.fetchDashboard();
  }

  Future<User> login(String username, String password) async {
    return await _apiClient.login(username, password);
  }
}
