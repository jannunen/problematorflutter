import 'package:problemator/models/models.dart';

class ProblemList {
  List<Problem> problems;
  List<String> attributesInUse;

  ProblemList({this.problems, this.attributesInUse});

  static ProblemList fromJson(Map<String, dynamic> json) {
    List<Problem> problems = new List();
    List<String> attributesInUse = new List();
    if (json['problems'] != null) {
      json['problems'].forEach((v) {
        problems.add(Problem.fromJson(v));
      });
      if (json['attributes_in_use'] != null) {
        json['attributes_in_use'].forEach((v) {
          attributesInUse.add(v);
        });
      }
      return ProblemList(problems: problems, attributesInUse: attributesInUse);
    }
  }
}
