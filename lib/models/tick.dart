import 'package:equatable/equatable.dart';

class Tick extends Equatable {
  final String problemid;
  final int tries;
  final String gradeOpinion;
  final String ascentType;
  final DateTime tickDate;
  final String preTick;

  Tick({this.problemid, this.tries, this.gradeOpinion, this.ascentType, this.tickDate, this.preTick});

  @override
  List<Object> get props => [problemid, tries, gradeOpinion, ascentType];

  Tick copyWith({problemid, tries, gradeOpinion, ascentType}) => Tick(
        problemid: problemid ?? this.problemid,
        tries: tries ?? this.tries,
        gradeOpinion: gradeOpinion ?? this.gradeOpinion,
        ascentType: ascentType ?? this.ascentType,
      );

  static Tick fromJson(Map<String, dynamic> json) {
    return new Tick(
      problemid: json['problemid'],
      tries: json['tries'],
      gradeOpinion: json['gradeOpinion'],
      ascentType: json['ascentType'],
    );
  }

  toMap() {
    return {
      'problemid' : this.problemid,
      'tickdate' : this.tickDate,
      'tries' : this.tries,
      'grade_opinion' : this.gradeOpinion,
      'ascent_type' : this.ascentType,
      'table' : this.preTick,
    }
  }
}
