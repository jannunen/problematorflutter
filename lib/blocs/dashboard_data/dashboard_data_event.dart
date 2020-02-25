
import 'package:equatable/equatable.dart';

abstract class DashboardDataEvent extends Equatable {
  const DashboardDataEvent();

  @override
  List<Object> get props => [props];
}

class LoadDashboardData extends DashboardDataEvent {
  @override
  String toString() => 'LoadDashboardData';
}