import 'package:problemator/api/api_client.dart';
import 'package:problemator/blocs/user/bloc/user_bloc.dart';
import 'package:problemator/models/gym.dart';
import 'package:problemator/models/models.dart';
import 'package:problemator/models/problem_extra_info.dart';
import 'package:problemator/models/responses/tick_response.dart';

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
        _apiClient.setGym(user.gymid);
      }
    });
  }
  /*
  void setApiKey(String key) {
    this.apiKey = key;
    this._apiClient.setApiKey(key);
  }

  void setGym(String gymid) {
    this._apiClient.setGym(gymid);
  }
  */

  Future<ProblemList> fetchProblems() async {
    return await _apiClient.getProblemList();
  }

  Future<ProblemExtraInfo> fetchProblemDetails(String problemid) async {
    return await _apiClient.fetchProblemDetails(problemid);
  }

  Future<Dashboard> fetchDashboard() async {
    return await _apiClient.fetchDashboard();
  }

  Future<User> login(String username, String password) async {
    return await _apiClient.login(username, password);
  }

  Future<TickResponse> addTick(Tick tick) async {
    return await _apiClient.addTick(tick);
  }

  Future<Problem> fetchProblem(String problemid, bool useCache) async {
    return await _apiClient.fetchProblem(problemid, useCache);
  }

  Future<List<Gym>> fetchGyms(bool useCache) async {
    return await _apiClient.fetchGyms(useCache);
  }
}
