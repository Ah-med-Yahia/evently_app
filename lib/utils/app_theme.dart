import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF5669FF);
  static const Color backgroundLight = Color(0xFFF0F0F0);
  static const Color backgroundDark = Color(0xFF101127);
  static const Color black = Color(0xFF1C1C1C);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gey = Color(0xFF7B7B7B);
  static const Color red = Color(0xFFFF5659);

  static ThemeData ligthTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: primaryColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: white,
      unselectedItemColor: white
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: white,
      shape: CircleBorder(side:  BorderSide(width: 5,color: white))
    )
  );
  static ThemeData darkTheme = ThemeData();
}
