import 'package:problemator/repository/repository.dart';

class ProblemListResponse {
  int totalProblems;
  List<ProblemEntity> problems;

  ProblemListResponse.fromJson(Map<String, dynamic> json) {

    if (json['problems'] != null) {
      problems = new List<ProblemEntity>();
      json['problems'].forEach((v) {
        problems.add(new ProblemEntity.fromJson(v));
      });
    }
  }
}

