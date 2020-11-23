import 'package:problemator/models/ascent.dart';

class ProblemExtraInfo {
  final List<Ascent> ascents;
  ProblemExtraInfo({this.ascents});

  static ProblemExtraInfo fromJson(Map<String, dynamic> json) {
    return ProblemExtraInfo();
  }
}
