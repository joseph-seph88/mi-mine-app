import 'package:flutter/material.dart';

abstract class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      bodyLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
      ),
      bodyMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
      ),
      bodySmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        color: Colors.black54,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.blue,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.blueAccent,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: Colors.blueGrey,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: Colors.white70,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white70,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
      ),
      bodyLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.white70,
      ),
      bodyMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.white70,
      ),
      bodySmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        color: Colors.white60,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.tealAccent,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.teal,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: Colors.teal[200],
      ),
    ),
  );
}