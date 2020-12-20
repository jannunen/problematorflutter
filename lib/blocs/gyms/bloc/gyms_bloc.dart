import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:problemator/api/repository_api.dart';
import 'package:problemator/models/gym.dart';

part 'gyms_event.dart';
part 'gyms_state.dart';

class GymsBloc extends Bloc<GymsEvent, GymsState> {
  final ProblemsRepository _problemsRepository;

  GymsBloc({problemsRepository})
      : this._problemsRepository = problemsRepository,
        super(GymsInitial());

  @override
  Stream<GymsState> mapEventToState(
    GymsEvent event,
  ) async* {
    if (event is FetchGyms) {
      final List<Gym> gyms = await _problemsRepository.fetchGyms(false);
      yield (GymsLoaded(gyms));
    }
  }
}
