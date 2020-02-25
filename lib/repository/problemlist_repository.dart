import 'dart:async';
import 'dart:core';

import 'problem_entity.dart';

abstract class ProblemListRepository {
  // Fetches the problems from cache or internet
  Future<List<ProblemEntity>> fetchProblems();

}

