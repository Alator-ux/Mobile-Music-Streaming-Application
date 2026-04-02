import 'package:flutter/material.dart';

class AppTheme {
  static const Color _lightPrimary = Color(0xFF6200EE);
  static const Color _lightBackground = Color(0xFFF5F5F7);
  static const Color _lightSurface = Color(0xFFFFFFFF);
  static const Color _lightSecondary = Color(0xFF03DAC6);
  static const Color _lightOnBackground = Color(0xFF121212);

  static const Color _darkPrimary = Color(0xFFBB86FC);
  static const Color _darkBackground = Color(0xFF121212);
  static const Color _darkSurface = Color(0xFF1E1E1E);
  static const Color _darkSecondary = Color(0xFFCF6679);
  static const Color _darkOnBackground = Color(0xFFE1E1E1);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: _lightPrimary,
        secondary: _lightSecondary,
        surface: _lightSurface,
        background: _lightBackground,
      ),
      scaffoldBackgroundColor: _lightBackground,

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: _lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),

      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: _lightOnBackground,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        titleLarge: TextStyle(
          color: _lightOnBackground,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        bodyLarge: TextStyle(color: _lightOnBackground, fontSize: 16),
        bodyMedium: TextStyle(color: Colors.grey, fontSize: 14),
        labelSmall: TextStyle(color: Colors.grey, letterSpacing: 1.2),
      ),

      listTileTheme: const ListTileThemeData(
        textColor: _lightOnBackground,
        iconColor: _lightOnBackground,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),

      iconTheme: const IconThemeData(color: _lightOnBackground),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: _lightSurface,
        selectedItemColor: _lightPrimary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _lightPrimary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: _darkPrimary,
        secondary: _darkSecondary,
        surface: _darkSurface,
        background: _darkBackground,
      ),
      scaffoldBackgroundColor: _darkBackground,

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: _darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),

      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: _darkOnBackground,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        titleLarge: TextStyle(
          color: _darkOnBackground,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        bodyLarge: TextStyle(color: _darkOnBackground, fontSize: 16),
        bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
        labelSmall: TextStyle(color: Colors.white54, letterSpacing: 1.2),
      ),

      listTileTheme: const ListTileThemeData(
        textColor: _darkOnBackground,
        iconColor: _darkOnBackground,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),

      iconTheme: const IconThemeData(color: _darkOnBackground),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: _darkSurface,
        selectedItemColor: _darkPrimary,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _darkPrimary,
          foregroundColor: Colors.black,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
