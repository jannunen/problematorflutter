import 'dart:async';
import 'dart:core';

import 'problem_entity.dart';

abstract class ProblemRepository {

  Future<ProblemEntity> fetchProblemDetails(String problemid);

}

