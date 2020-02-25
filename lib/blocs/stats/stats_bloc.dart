import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:problemator/blocs/blocs.dart';
import 'package:problemator/blocs/stats/stats.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final ProblemsBloc problemsBloc;
  StreamSubscription problemsSubscription;

  StatsBloc({@required this.problemsBloc}) {
    problemsSubscription = problemsBloc.listen((state) {
      if (state is ProblemsLoaded) {
        add(UpdateStats(state.problems));
      }
    });
  }

  @override
  StatsState get initialState => StatsLoading();

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is UpdateStats) {
      int numActive =
          event.problems.where((problem) => problem.ticked ==null).toList().length;
      int numCompleted =
          event.problems.where((problem) => problem.ticked != null).toList().length;
      yield StatsLoaded(numActive, numCompleted);
    }
  }

  @override
  Future<void> close() {
    problemsSubscription.cancel();
    return super.close();
  }
}
