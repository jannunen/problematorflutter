part of 'gyms_bloc.dart';

abstract class GymsEvent extends Equatable {
  const GymsEvent();

  @override
  List<Object> get props => [];
}

class FetchGyms extends GymsEvent {
  List<Object> get props => ['fetchgyms'];
}
