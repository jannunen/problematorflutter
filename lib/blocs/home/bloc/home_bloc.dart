import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:problemator/api/repository_api.dart';
import 'package:problemator/blocs/user/bloc/user_bloc.dart';
import 'package:problemator/models/models.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserBloc userBloc;
  final ProblemsRepository _problemsRepository;

  HomeBloc({this.userBloc, problemsRepository})
      : this._problemsRepository = problemsRepository,
        super(HomeInitial()) {
    userBloc.listen((user) {
      // IF user is NOT empty, load the home page.
      this._problemsRepository.apiKey = user.jwt;
      add(InitializeHomeScreenEvent());
    });
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (state is HomeInitial) {
      final Dashboard dashboard = await _problemsRepository.fetchDashboard();
      yield (HomeLoaded(dashboard));
    } else if (state is InitializeHomeScreenEvent) {}
  }
}
