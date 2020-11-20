import 'package:problemator/api/api_client.dart';
import 'package:problemator/blocs/user/bloc/user_bloc.dart';
import 'package:problemator/models/models.dart';

///
/// Class handles the actual data fetching from the API.
///
class ProblemsRepository {
  final ApiClient _apiClient;
  final UserBloc userBloc;
  String apiKey = "";
  ProblemsRepository({ApiClient apiClient, this.userBloc}) : _apiClient = apiClient ?? ApiClient() {
    userBloc.listen((user) {
      // Get the api key...
      if (user != User.empty) {
        this.apiKey = user.jwt;
        _apiClient.setToken(user.jwt);
      }
    });
  }

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
