import 'dart:collection';

import 'package:problemator/repository/problem_entity.dart';

class ProblemDetailsResponse {
  ProblemEntity problem;

  ProblemDetailsResponse.fromJson(Map<String, dynamic> json) {

    if (json != null) {
      problem = new ProblemEntity.fromJson(json);
    }
  }
}

