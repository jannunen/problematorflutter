import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:problemator/api/repository_api.dart';
import 'package:problemator/models/models.dart';
import 'package:problemator/models/problem_extra_info.dart';

part 'problem_event.dart';
part 'problem_state.dart';

class ProblemBloc extends Bloc<ProblemEvent, ProblemState> {
  final ProblemsRepository problemsRepository;

  ProblemBloc({this.problemsRepository}) : super(ProblemInitial());

  @override
  Stream<ProblemState> mapEventToState(
    ProblemEvent event,
  ) async* {
    if (event is LoadProblemExtraInfo) {
      // SFech extra info an yield state
      yield (AddingTick());
      final ProblemExtraInfo problemExtraInfo =
          await problemsRepository.fetchProblemDetails(event.id);
      yield (ProblemExtraInfoLoaded(problemExtraInfo: null));
    } else if (event is AddTick) {
      final Tick tick = await problemsRepository.addTick(event.tick);
      yield (TickAdded(addedTick: tick));
    }
  }
}
