import 'package:equatable/equatable.dart';
import 'package:problemator/models/models.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class UpdateStats extends StatsEvent {
  final List<Problem> problems;

  const UpdateStats(this.problems);

  @override
  List<Object> get props => [problems];

  @override
  String toString() => 'UpdateStats { problems: $problems }';
}
