import 'dart:async';

import 'package:problemator/api/ProblemRepository.dart';
import 'package:problemator/api/blocs/bloc.dart';
import 'package:problemator/models/Problem.dart';
import 'package:problemator/api/ApiResponse.dart';

class ProblemDetailsBloc implements Bloc {
  ProblemRepository _problemRepository;

  StreamController _problemDetailsController;

  StreamSink<ApiResponse<Problem>> get problemDetailsSink =>
      _problemDetailsController.sink;

  Stream<ApiResponse<Problem>> get problemDetailsStream =>
      _problemDetailsController.stream;

  ProblemDetailsBloc() {
    _problemDetailsController = StreamController<ApiResponse<Problem>>();
    _problemRepository = ProblemRepository();
  }

  fetchProblemDetails(String problemid) async {
    problemDetailsSink.add(ApiResponse.loading('Fetching Problem Details'));
    try {
      Problem problem = await _problemRepository.fetchProblemDetails(problemid);
      problemDetailsSink.add(ApiResponse.completed(problem));
    } catch (e) {
      problemDetailsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _problemDetailsController?.close();
  }
}
