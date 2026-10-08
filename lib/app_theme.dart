import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',

      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF8F6FC),
        foregroundColor: Colors.black,
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 22,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
      ),

      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w900,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w900,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w900,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w900,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w900,
        ),
        titleSmall: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w900,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w900,
        ),
      ),

      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.indigo,
        brightness: Brightness.light,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',

      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 22,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),

      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w900,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w900,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w900,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w900,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w900,
        ),
        titleSmall: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w900,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w900,
        ),
      ),

      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.indigo,
        brightness: Brightness.dark,
      ),
    );
  }
}