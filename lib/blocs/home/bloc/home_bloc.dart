import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:problemator/api/repository_api.dart';
import 'package:problemator/blocs/gyms/bloc/gyms_bloc.dart';
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
  final GymsBloc _gymsBloc;

  HomeBloc({userBloc, problemsRepository, problemBloc, problemsBloc, gymsBloc})
      : this._problemsRepository = problemsRepository,
        this._problemBloc = problemBloc,
        this._problemsBloc = problemsBloc,
        this._userBloc = userBloc,
        this._gymsBloc = gymsBloc,
        super(HomeInitial()) {
    _userBloc.listen((user) {
      // IF user is NOT empty, load the home page.
      add(InitializeHomeScreenEvent());
    });
    _problemsBloc.listen((ProblemsState state) async {
      if (state is ProblemsLoaded) {
        // Add the problems to this state.
        add(UpdateProblems(state.problems));
      }
    });
    _problemBloc.listen((ProblemState state) async {
      if (state is TickAdded) {
        // upadte fdfashhobhoihasd
        final Dashboard dashboard = (this.state as HomeLoaded).dashboard;

        final String problemid = state.addedTick.problemid;
        final Problem updatedProblem = await _problemsRepository.fetchProblem(problemid, false);
        List problems = dashboard.problems;
        // get updated problem info and incorporate that into the dashboard.
        //Problem updatedProblem = state.problem;
        // Find which problems..
        int index = dashboard.problems
            .indexWhere((Problem problem) => problem.problemid == updatedProblem.problemid);

        if (index != -1) {
          // Problem found, update problem
          problems[index] = updatedProblem;
        }
        Dashboard updatedDashboard = dashboard.copyWith(problems: problems);
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
      // Get list of gyms
      _gymsBloc.add(FetchGyms());
      yield (HomeLoaded(dashboard));
    }
  }
}
