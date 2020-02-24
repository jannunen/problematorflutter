import 'dart:collection';

import 'package:problemator/models/Problem.dart';

class ProblemDetailsResponse {
  Problem problem;

  ProblemDetailsResponse.fromJson(Map<String, dynamic> json) {

    if (json != null) {
      problem = new Problem.fromJson(json);
    }
  }
}
