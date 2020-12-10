import 'package:problemator/models/models.dart';

class ProblemList {
  List<Problem> problems;

  ProblemList({this.problems});

  static ProblemList fromJson(Map<String, dynamic> json) {
    if (json['problems'] != null) {
      List<Problem> problems = new List();
      json['problems'].forEach((v) {
        problems.add(Problem.fromJson(v));
      });
      return ProblemList(problems: problems);
    }
  }
}
