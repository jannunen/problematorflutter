import 'package:problemator/api/api_helper.dart';
import 'package:problemator/models/models.dart';
import 'package:problemator/models/problem_extra_info.dart';

class ApiClient {
  final ApiHelper _helper = ApiHelper();
  String _apiKey;
  /*
  final String _apiKey =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE2MDU3ODk5OTMsImp0aSI6Ik5qRT0iLCJpc3MiOiJ3d3cucHJvYmxlbWF0b3IuZmkiLCJuYmYiOjE2MDU3ODk5OTMsImV4cCI6MTYwODM4MTk5MywiZGF0YSI6eyJ1c2VySWQiOiIyNDYiLCJmaXJzdG5hbWUiOiJKYXJtbyIsImxhc3RuYW1lIjoiQW5udW5lbiIsImVtYWlsIjoiamFybW9AYW5udW5lbi5maSIsImd5bWlkIjoiMSJ9fQ.KmsEtPHY4ZZxPfsES1Rku4A0sTZoZTOPJunxukApQj3EzfF7nfM2H84iCNjov0yUsqGt7LGiRRQm_b7DA4LdTQ";
      */
  void setApiKey(String key) {
    this._apiKey = key;
  }

  Future<ProblemList> getProblemList() async {
    final response = await _helper.get("problemlist/?react=true&api-auth-token=$_apiKey");
    return ProblemList.fromJson(response);
  }

  Future<ProblemExtraInfo> fetchProblemDetails(String problemid) async {
    final response =
        await _helper.get("problem/" + problemid + "?react=true&api-auth-token=$_apiKey");
    ProblemExtraInfo problem = ProblemExtraInfo.fromJson(response['problem']);
    return problem;
  }

  Future<Dashboard> fetchDashboard() async {
    final response = await _helper.get("dashinfo/?react=true&api-auth-token=$_apiKey");
    Dashboard dashboard = Dashboard.fromJson(response);
    return dashboard;
  }

  Future<User> login(String email, String password) async {
    final response = await _helper.get("dologin/?username=" +
        email +
        "&password=" +
        password +
        "&react=true&api-auth-token=$_apiKey");
    if (response.containsKey('error') && response['error'] == 'true') {
      throw new Exception(response['message']);
    }
    response['email'] = email;
    response['id'] = response['uid'];
    User login = User.fromJson(response);
    return login;
  }

  Future<User> logout() async {
    final response = await _helper.get("logout/?react=true&api-auth-token=$_apiKey");
    if (response.containsKey('error') && response['error'] == 'true') {
      throw new Exception(response['message']);
    }
    return User.empty;
  }

  void setToken(String jwt) {
    this._apiKey = jwt;
  }

  Future<Tick> addtick(Tick tick) async {
    final response =
        await _helper.post("/savetick/?react=true&api-auth-token=$_apiKey", tick.toMap());
    if (response.containsKey('error') && response['error'] == 'true') {
      throw new Exception(response['message']);
    }
    Tick backTick = Tick.fromJson(response);
    return backTick;
  }
}
