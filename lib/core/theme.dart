import 'package:flutter/material.dart';

ThemeData themeData() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Poppins',
    textTheme: textTheme(),
  );
}

TextTheme textTheme() {
  return const TextTheme(
      headline1: TextStyle(
    color: Colors.black,
    fontSize: 32,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
  ),
    headline2: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    ),      headline5: TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
  ),
    headline6: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.normal,
    ),
    bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.normal,
    ),
    bodyText2: TextStyle(
    color: Colors.black,
    fontSize: 10,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.normal,
  ),
  );
}
