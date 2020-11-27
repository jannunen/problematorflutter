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
  final Problem problem; // When adding new tick, it will return the problem reference

  Tick({
    this.id,
    this.problemid,
    this.tries,
    this.gradeOpinion,
    this.ascentType,
    this.tickDate,
    this.preTick,
    this.problem,
  });

  @override
  List<Object> get props => [problemid, tries, gradeOpinion, ascentType];

  Tick copyWith({problemid, tries, gradeOpinion, ascentType, problem}) => Tick(
        problemid: problemid ?? this.problemid,
        tries: tries ?? this.tries,
        gradeOpinion: gradeOpinion ?? this.gradeOpinion,
        ascentType: ascentType ?? this.ascentType,
        problem: problem ?? this.problem,
      );

  static Tick fromJson(Map<String, dynamic> json) {
    return new Tick(
      id: json['id'],
      problemid: json['problemid'],
      tries: int.tryParse(json['tries']) ?? 0,
      gradeOpinion: json['gradeOpinion'],
      ascentType: json['ascentType'],
      problem: json['problem'] != null ? Problem.fromJson(json['problem']) : null,
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
    };
    if (removeNulls) {
      returnMap.removeWhere((key, value) => key == null || value == null);
    }
    return returnMap;
  }
}
