part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class UpdateDashboard extends HomeEvent {
  final Dashboard dashboard;
  UpdateDashboard(this.dashboard);
  @override
  List<Object> get props => [dashboard];
}

class InitializeHomeScreenEvent extends HomeEvent {}
