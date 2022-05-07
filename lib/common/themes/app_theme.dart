import 'package:flutter/material.dart';

const String globalFont = 'RobotoFlex';

class AppTheme {
  static ThemeData themeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color.fromRGBO(33, 42, 57, 1),
    primarySwatch: Colors.orange,
    backgroundColor: const Color.fromRGBO(98, 109, 133, 0.5),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.black, //Color.fromRGBO(33, 42, 57, 1),
      splashColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      textTheme: ButtonTextTheme.accent
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.red,
    ),
    // fontFamily: 'Roboto',
    fontFamily: globalFont,
    textTheme: const TextTheme(
      button: TextStyle(fontFamily: globalFont, fontWeight: FontWeight.w400, fontSize: 14),
      headline1: TextStyle(fontFamily: globalFont, fontWeight: FontWeight.w900, fontSize: 22),
      headline2: TextStyle(fontFamily: globalFont, fontWeight: FontWeight.w600, fontSize: 20),
      headline3: TextStyle(fontFamily: globalFont, fontWeight: FontWeight.w900, fontSize: 18),
      headline4: TextStyle(fontFamily: globalFont, fontWeight: FontWeight.w400, fontSize: 16),
      headline5: TextStyle(fontFamily: globalFont, fontWeight: FontWeight.w400, fontSize: 14),
      bodyText1: TextStyle(fontFamily: '', fontWeight: FontWeight.w400, fontSize: 14),
      bodyText2: TextStyle(fontFamily: '', fontWeight: FontWeight.w400, fontSize: 14),
    ),
  );
}
