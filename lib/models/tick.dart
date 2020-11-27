import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:problemator/models/problem.dart';

class Tick extends Equatable {
  final String id;
  final String problemid;
  final int tries;
  final String gradeOpinion;
  final String ascentType;
  final DateTime tickDate;
  final String preTick;
  final String tickType;

  Tick({
    this.id,
    this.problemid,
    this.tries,
    this.gradeOpinion,
    this.ascentType,
    this.tickDate,
    this.tickType,
    this.preTick,
  });

  @override
  List<Object> get props => [problemid, tries, gradeOpinion, ascentType, tickType];

  Tick copyWith({problemid, tries, gradeOpinion, ascentType, problem}) => Tick(
        problemid: problemid ?? this.problemid,
        tries: tries ?? this.tries,
        gradeOpinion: gradeOpinion ?? this.gradeOpinion,
        ascentType: ascentType ?? this.ascentType,
        tickType: tickType ?? this.tickType,
      );

  static Tick fromJson(Map<String, dynamic> json) {
    return new Tick(
      id: json['id'],
      problemid: json['problemid'],
      tries: int.tryParse(json['tries']) ?? 0,
      gradeOpinion: json['gradeOpinion'],
      ascentType: json['ascentType'],
      tickType: json['tick_type'],
    );
  }

  toMap() {
    DateFormat format = DateFormat("yyyy-MM-dd");
    return {
      'problemid': this.problemid,
      'tickdate':
          (this.tickDate == null) ? format.format(DateTime.now()) : format.format(this.tickDate),
      'tries': this.tries,
      'grade_opinion': this.gradeOpinion,
      'ascent_type': this.ascentType,
      'table': this.preTick,
      'tick_type': this.tickType,
    };
  }

  toPostMap([bool removeNulls = false]) {
    DateFormat format = DateFormat("yyyy-MM-dd");
    Map<String, String> returnMap = {
      'problemid': this.problemid ?? "",
      'tickdate':
          (this.tickDate == null) ? format.format(DateTime.now()) : format.format(this.tickDate),
      'tries': this.tries.toString(),
      'grade_opinion': this.gradeOpinion ?? null,
      'ascent_type': this.ascentType ?? null,
      'table': this.preTick ?? null,
      'tick_type': this.tickType ?? null,
    };
    if (removeNulls) {
      returnMap.removeWhere((key, value) => key == null || value == null);
    }
    return returnMap;
  }
}
