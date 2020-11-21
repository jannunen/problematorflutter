import 'package:flutter/material.dart';

enum AppTheme {
  Light,
  Dark,
}

final appThemeData = {
  AppTheme.Dark: ThemeData(
      fontFamily: 'Fira Sans',
      backgroundColor: Colors.grey[800],
      brightness: Brightness.dark,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.grey[700],
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.white70),
        bodyText2: TextStyle(color: Colors.white70),
        headline1:
            TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.grey.shade100),
        headline2:
            TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.grey.shade100),
        headline3:
            TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.grey.shade100),
        headline4:
            TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.grey.shade100),
      )),
  AppTheme.Light: ThemeData(
    fontFamily: 'Fira Sans',
    backgroundColor: Color.fromRGBO(229, 229, 229, 0.9),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color.fromRGBO(229, 229, 229, 0.9),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.black87),
      bodyText2: TextStyle(color: Colors.black87),
      headline1: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.black87),
      headline2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black87),
      headline3: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black87),
      headline4: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black87),
    ),
  ),
};
