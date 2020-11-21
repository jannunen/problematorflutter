import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  Color get roundButtonBackground => brightness == Brightness.light
      ? const Color.fromRGBO(47, 45, 81, 0.9) // #2f2d51
      : const Color.fromRGBO(47, 45, 81, 0.9);

  Color get roundButtonTextColor => brightness == Brightness.light ? Colors.black87 : Colors.white;

  Color get gymFloorPlanBackroundCOlor => brightness == Brightness.light
      ? Color.fromRGBO(224, 224, 224, 0.3)
      : Color.fromRGBO(224, 224, 224, 0.2);
  Color get myLogsContainerBackgroundColor => brightness == Brightness.light
      ? Color.fromRGBO(248, 249, 247, 1.0)
      : Color.fromRGBO(94, 73, 85, 1.0);
  Color get myLogsTextColor => brightness == Brightness.light ? Colors.black87 : Colors.white;
  Color get myLogsHeaderTextColor => brightness == Brightness.light
      ? Color.fromRGBO(159, 252, 223, 1.0)
      : Color.fromRGBO(59, 178, 115, 1.0);
}
