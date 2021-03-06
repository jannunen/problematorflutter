part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final Dashboard dashboard;

  const HomeState({this.dashboard});

  @override
  List<Object> get props => [dashboard];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final Dashboard dashboard;
  HomeLoaded(this.dashboard);

  List<Object> get props => [dashboard];
}

class HomeLoadError extends HomeState {}
