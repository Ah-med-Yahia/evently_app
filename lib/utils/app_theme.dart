import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF5669FF);
  static const Color backgroundLight = Color(0xFFF0F0F0);
  static const Color backgroundDark = Color(0xFF101127);
  static const Color black = Color(0xFF1C1C1C);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF7B7B7B);
  static const Color red = Color(0xFFFF5659);

  static ThemeData ligthTheme = ThemeData(
    scaffoldBackgroundColor: backgroundLight,
    textTheme: const TextTheme(
      titleLarge:  TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: white
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: black
      )
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline
        )
      )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        )
      )
    ),
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
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: grey,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1,color: grey),
        borderRadius: BorderRadius.circular(16)
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1,color: grey),
        borderRadius: BorderRadius.circular(16)
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1,color: red),
        borderRadius: BorderRadius.circular(16)
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1,color: red),
        borderRadius: BorderRadius.circular(16)
      ),
      
    ),
    
  );
  static ThemeData darkTheme = ThemeData();
}
