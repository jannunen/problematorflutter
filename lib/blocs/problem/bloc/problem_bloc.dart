import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:problemator/api/repository_api.dart';
import 'package:problemator/blocs/problem/problem_bloc.dart';
import 'package:problemator/models/models.dart';
import 'package:problemator/models/problem_extra_info.dart';
import 'package:problemator/models/responses/tick_response.dart';

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
      yield (ProblemExtraInfoLoaded(problemExtraInfo: problemExtraInfo));
    } else if (event is AddTick) {
      ProblemExtraInfo problemExtraInfo = (this.state as ProblemExtraInfoLoaded).problemExtraInfo;
      try {
        final TickResponse tickResponse = await problemsRepository.addTick(event.tick);
        // Remember that HomeBloc is listening to states so it gets the updated problem info also
        yield (TickAdded(
            addedTick: tickResponse.tick,
            problemExtraInfo: problemExtraInfo,
            problem: tickResponse.problem));
      } catch (e) {
        yield (TickAddFailed(e.toString(), problemExtraInfo));
      }
    } else if (event is LikeProblem) {
      print(event.problem);
      final Problem problem = await problemsRepository.likeProblem(event.problem);
      yield (LikingProblem());
      try {
        yield (LikedProblem());
      } catch (e) {
        yield (LikeProblemFailed(e.toString()));
      }
    }
  }
}
