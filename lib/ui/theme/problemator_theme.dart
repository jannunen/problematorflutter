import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  TextStyle get problematorAccentStyle => brightness == Brightness.light
      ? TextStyle(color: this.accentColor, fontWeight: FontWeight.bold)
      : TextStyle(color: this.accentColor, fontWeight: FontWeight.bold);

  BorderRadius get textFieldBorderRadius => BorderRadius.all(const Radius.circular(26));

  Color get activeButtonColor => brightness == Brightness.light
      ? const Color.fromRGBO(245, 199, 36, 1)
      : const Color.fromRGBO(218, 180, 43, 1);

  Color get roundButtonBackground => brightness == Brightness.light
      ? const Color.fromRGBO(47, 45, 81, 0.9) // #2f2d51
      : const Color.fromRGBO(147, 145, 181, 0.9);

  Color get roundButtonTextColor => brightness == Brightness.light ? Colors.black87 : Colors.white;

// DASHBOARD
  Color get gymFloorPlanBackroundColor => brightness == Brightness.light
      ? Color.fromRGBO(224, 224, 224, 0.3)
      : Color.fromRGBO(224, 224, 224, 0.2);
  Color get myLogsContainerBackgroundColor => brightness == Brightness.light
      ? Color.fromRGBO(248, 249, 247, 1.0)
      : Color.fromRGBO(94, 73, 85, 1.0);
  Color get myLogsTextColor => brightness == Brightness.light ? Colors.black87 : Colors.white;
  Color get myLogsHeaderTextColor => brightness == Brightness.light
      ? Color.fromRGBO(159, 252, 223, 1.0)
      : Color.fromRGBO(59, 178, 115, 1.0);

  // PROBLEM PAGE
  Color get leftPaneBackground => brightness == Brightness.light
      ? Color.fromRGBO(94, 73, 85, 1.0)
      : Color.fromRGBO(94, 94, 94, 1.0);
  Color get accentColor => brightness == Brightness.light
      ? Color.fromRGBO(47, 45, 81, 1.0)
      : Color.fromRGBO(197, 195, 231, 0.9);
}
