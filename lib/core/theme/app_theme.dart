import 'package:flutter/material.dart';

class AppTheme {
  static const Color PRIMARY_COLOR = Color(0xFF005AA0);
  static const Color SECONDARY_COLOR = Color(0xFF00A3E0);
  static const Color ERROR_COLOR = Color(0xFFD32F2F);
  static const Color WARNING_COLOR = Color(0xFFF57C00);
  static const Color SUCCESS_COLOR = Color(0xFF388E3C);
  
  static const Color BACKGROUND_LIGHT = Color(0xFFFAFAFA);
  static const Color SURFACE_LIGHT = Color(0xFFFFFFFF);
  static const Color BACKGROUND_DARK = Color(0xFF121212);
  static const Color SURFACE_DARK = Color(0xFF1E1E1E);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: PRIMARY_COLOR,
        secondary: SECONDARY_COLOR,
        error: ERROR_COLOR,
        surface: SURFACE_LIGHT,
        background: BACKGROUND_LIGHT,
      ),
      scaffoldBackgroundColor: BACKGROUND_LIGHT,
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: SURFACE_LIGHT,
        foregroundColor: Colors.black87,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: PRIMARY_COLOR, width: 2),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: SECONDARY_COLOR,
        secondary: PRIMARY_COLOR,
        error: ERROR_COLOR,
        surface: SURFACE_DARK,
        background: BACKGROUND_DARK,
      ),
      scaffoldBackgroundColor: BACKGROUND_DARK,
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: SURFACE_DARK,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: SECONDARY_COLOR, width: 2),
        ),
      ),
    );
  }
}
