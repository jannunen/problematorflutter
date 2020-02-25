import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:problemator/blocs/problem/problem.dart';


class ProblemBloc extends Bloc<ProblemEvent, ProblemState> {
  @override
  ProblemState get initialState => ProblemInitial();

  @override
  Stream<ProblemState> mapEventToState(
    ProblemEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
