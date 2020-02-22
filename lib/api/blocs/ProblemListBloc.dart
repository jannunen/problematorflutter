import 'dart:async';

import 'package:problemator/api/ProblemRepository.dart';
import 'package:problemator/models/Problem.dart';

import 'package:problemator/api/ApiResponse.dart';

class ProblemListBloc {
  ProblemRepository _problemRepository;

  StreamController _problemListController;

  StreamSink<ApiResponse<List<Problem>>> get problemListSink =>
      _problemListController.sink;

  Stream<ApiResponse<List<Problem>>> get problemListStream =>
      _problemListController.stream;

  ProblemListBloc() {
    _problemListController = StreamController<ApiResponse<List<Problem>>>();
    _problemRepository = ProblemRepository();
    fetchProblemList();
  }

  fetchProblemList() async {
    problemListSink.add(ApiResponse.loading('Fetching Problems'));
    try {
      List<Problem> problems = await _problemRepository.fetchProblemList();
      problemListSink.add(ApiResponse.completed(problems));
    } catch (e) {
      problemListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _problemListController?.close();
  }
}
