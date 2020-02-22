import 'package:problemator/models/Problem.dart';

class ProblemListResponse {
  int totalProblems;
  List<Problem> problems;

  ProblemListResponse.fromJson(Map<String, dynamic> json) {

    if (json['problems'] != null) {
      problems = new List<Problem>();
      json['problems'].forEach((v) {
        problems.add(new Problem.fromJson(v));
      });
    }
  }
}

