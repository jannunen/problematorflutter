import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:problemator/blocs/problem/problem.dart';

class ProblemBloc extends Bloc<ProblemEvent, ProblemState> {
  ProblemBloc() : super(ProblemInitial());

  @override
  Stream<ProblemState> mapEventToState(
    ProblemEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
