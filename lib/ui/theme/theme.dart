import 'package:flutter/material.dart';

enum AppTheme {
  Light,
  Dark,
}

final appThemeData = {
  AppTheme.Dark: ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'Nunito',
      primaryColor: Colors.white,
      backgroundColor: Colors.grey[800],
      brightness: Brightness.dark,
      textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.white70),
        bodyText2: TextStyle(color: Colors.white70),
        headline1:
            TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.grey.shade100),
        headline2:
            TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.grey.shade100),
        headline3:
            TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.grey.shade100),
        headline4:
            TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.grey.shade100),
      )),
  AppTheme.Light: ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Nunito',
    primaryColor: Colors.black87,
    backgroundColor: Color.fromRGBO(229, 229, 229, 0.9),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color.fromRGBO(229, 229, 229, 0.9),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.black87),
      bodyText2: TextStyle(color: Colors.black87),
      headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black87),
      headline2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black87),
      headline3: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black87),
      headline4: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black87),
    ),
  ),
};
