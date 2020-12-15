import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:problemator/models/problem.dart';
import 'package:problemator/models/tick.dart';

class TickResponse extends Equatable {
  final Tick tick;
  final Problem problem;
  final String message;

  TickResponse({
    this.problem,
    this.tick,
    this.message,
  });

  @override
  List<Object> get props => [problem, tick, message];

  TickResponse copyWith({problem, tick, message}) => TickResponse(
      problem: problem ?? this.problem, tick: tick ?? this.tick, message: message ?? this.message);

  static TickResponse fromJson(Map<String, dynamic> json) {
    return new TickResponse(
        problem: Problem.fromJson(json['problem']),
        tick: Tick.fromJson(json['tick']),
        message: json['message']);
  }

  toMap() {
    DateFormat format = DateFormat("yyyy-MM-dd");
    return {
      'problem': this.problem,
      'tick': this.tick,
      'message': this.message,
    };
  }
}
