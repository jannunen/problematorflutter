part of 'gyms_bloc.dart';

abstract class GymsState extends Equatable {
  const GymsState();

  @override
  List<Object> get props => [];
}

class GymsInitial extends GymsState {}

class GymsLoaded extends GymsState {
  final List<Gym> gyms;
  GymsLoaded(this.gyms);
}

class GymsLoading extends GymsState {}

class GymsLoadError extends GymsState {}
