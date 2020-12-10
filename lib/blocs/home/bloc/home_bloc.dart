import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:problemator/api/repository_api.dart';
import 'package:problemator/blocs/problem/problem_bloc.dart';
import 'package:problemator/blocs/problems/problems_bloc.dart';
import 'package:problemator/blocs/problems/problems_event.dart';
import 'package:problemator/blocs/problems/problems_state.dart';
import 'package:problemator/blocs/user/bloc/user_bloc.dart';
import 'package:problemator/models/models.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserBloc _userBloc;
  final ProblemsRepository _problemsRepository;
  final ProblemBloc _problemBloc;
  final ProblemsBloc _problemsBloc;

  HomeBloc({userBloc, problemsRepository, problemBloc, problemsBloc})
      : this._problemsRepository = problemsRepository,
        this._problemBloc = problemBloc,
        this._problemsBloc = problemsBloc,
        this._userBloc = userBloc,
        super(HomeInitial()) {
    _userBloc.listen((user) {
      // IF user is NOT empty, load the home page.
      this._problemsRepository.apiKey = user.jwt;
      add(InitializeHomeScreenEvent());
    });
    _problemsBloc.listen((ProblemsState state) async {
      if (state is ProblemsLoaded) {
        final ProblemsLoaded newState = (state as ProblemsLoaded);
        // Add the problems to this state.
        add(UpdateProblems(newState.problems));
      }
    });
    _problemBloc.listen((ProblemState state) async {
      if (state is TickAdded) {
        // upadte fdfashhobhoihasd
        final Dashboard dashboard = (this.state as HomeLoaded).dashboard;
        Dashboard updatedDashboard = dashboard.copyWith();

        final String problemid = state.addedTick.problemid;
        final Problem updatedProblem = await _problemsRepository.fetchProblem(problemid, false);
        // get updated problem info and incorporate that into the dashboard.
        //Problem updatedProblem = state.problem;
        List<Problem> problems = updatedDashboard.problems;
        // Find which problems..
        int index =
            problems.indexWhere((Problem problem) => problem.problemid == updatedProblem.problemid);

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
    } else if (event is UpdateProblems) {
      // Check that the state is HomeLoaded
      if (state is HomeLoaded) {
        Dashboard updatedDashboard =
            (state as HomeLoaded).dashboard.copyWith(problems: event.problems);
        yield (HomeLoaded(updatedDashboard));
      }
    } else if (event is UpdateDashboard) {
      yield (HomeLoaded(event.dashboard));
    } else if (event is InitializeHomeScreenEvent) {
      final Dashboard dashboard = await _problemsRepository.fetchDashboard();
      // Load also problemlist
      _problemsBloc.add(LoadProblems());
      yield (HomeLoaded(dashboard));
    }
  }
}
