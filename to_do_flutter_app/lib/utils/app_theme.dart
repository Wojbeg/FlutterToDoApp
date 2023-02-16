import 'package:flutter/material.dart';

enum AppTheme {
  lightTheme,
  darkTheme,
}

class AppThemes {
  static final Map<int, Color> _whiteSwatch = {
      50: Color(0xFFFFFFFF),
      100: Color(0xFFF7F7F7),
      200: Color(0xFFECECEC),
      300: Color(0xFFE0E0E0),
      400: Color(0xFFD5D5D5),
      500: Color(0xFFC9C9C9),
      600: Color(0xFFBEBEBE),
      700: Color(0xFFB2B2B2),
      800: Color(0xFFA7A7A7),
      900: Color(0xFF9B9B9B),
    };

  static final Map<int, Color> _blackSwatch = {
    50: Color(0xFFFAFAFA),
    100: Color(0xFFF2F2F2),
    200: Color(0xFFE5E5E5),
    300: Color(0xFFD9D9D9),
    400: Color(0xFFCCCCCC),
    500: Color(0xFFBFBFBF),
    600: Color(0xFFB3B3B3),
    700: Color(0xFFA6A6A6),
    800: Color(0xFF999999),
    900: Color(0xFF8C8C8C),
  };

  static final appThemeData = {
    AppTheme.darkTheme: ThemeData(
      // primarySwatch: MaterialColor(0xFFFFFFFF, _whiteSwatch),
      primarySwatch: Colors.amber,
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      backgroundColor: const Color(0xFF212121),
      dividerColor: Colors.black54,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
      textTheme: const TextTheme(
        subtitle1: TextStyle(color: Colors.white),
        // headline5: TextStyle(color: Colors.black),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF424242), 
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.amber,
        ),

    ),


    AppTheme.lightTheme: ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.white,
      brightness: Brightness.light,
      backgroundColor: const Color(0xFFE5E5E5),
      dividerColor: const Color(0xff757575),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),
      ),
      textTheme: const TextTheme(
        subtitle1: TextStyle(color: Colors.black),
        // headline5: TextStyle(color: Colors.white),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black),
    ),
  };
}
