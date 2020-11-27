import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:problemator/api/repository_api.dart';
import 'package:problemator/blocs/problem/problem_bloc.dart';
import 'package:problemator/blocs/user/bloc/user_bloc.dart';
import 'package:problemator/models/models.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserBloc userBloc;
  final ProblemsRepository _problemsRepository;
  final ProblemBloc _problemBloc;

  HomeBloc({this.userBloc, problemsRepository, problemBloc})
      : this._problemsRepository = problemsRepository,
        this._problemBloc = problemBloc,
        super(HomeInitial()) {
    userBloc.listen((user) {
      // IF user is NOT empty, load the home page.
      this._problemsRepository.apiKey = user.jwt;
      add(InitializeHomeScreenEvent());
    });
    problemBloc.listen((ProblemState state) async {
      if (state is TickAdded) {
        // upadte fdfashhobhoihasd
        final Dashboard dashboard = (this.state as HomeLoaded).dashboard;
        Dashboard updatedDashboard = dashboard.copyWith();

        final String problemid = state.addedTick.problemid;
        final Problem updatedProblem = await _problemsRepository.fetchProblem(problemid);
        // get updated problem info and incorporate that into the dashboard.
        //Problem updatedProblem = state.problem;
        List<Problem> problems = updatedDashboard.problems;
        // Find which problems..
        int index = problems.indexWhere((Problem problem) => problem.id == updatedProblem.id);
        if (index != -1) {
          // Problem found, update problem
          problems[index] = updatedProblem;
        }
        updatedDashboard.problems = problems;
        add(UpdateDashboard(updatedDashboard));
      }
    });
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeInitial) {
    } else if (event is UpdateDashboard) {
      yield (HomeLoaded(event.dashboard));
    } else if (event is InitializeHomeScreenEvent) {
      final Dashboard dashboard = await _problemsRepository.fetchDashboard();
      yield (HomeLoaded(dashboard));
    }
  }
}
