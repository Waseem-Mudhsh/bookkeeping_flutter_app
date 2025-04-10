import 'package:flutter/material.dart';

class AppColors {
  // Light Mode Colors
  static const Color lightPrimary = Color(0xFF3D455A);
  static const Color lightSecondary = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightError = Color(0xFFDC3545);
  static const Color lightAccent = Color(0xFF28A745);

  // Dark Mode Colors
  static const Color darkPrimary = Color(0xFFFFFFFF);
  static const Color darkSecondary = Color(0xFF3D455A);
  static const Color darkSurface = Color(0xFF3D455A);
  static const Color darkError = Color(0xFFCF6679);
  static const Color darkAccent = Color(0xFF28A745);

  // Method to get the appropriate color scheme
  static ColorScheme getColorScheme(bool isDarkMode) {
    return ColorScheme(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primary: isDarkMode ? darkPrimary : lightPrimary,
      onPrimary: isDarkMode ? lightPrimary : darkPrimary,
      secondary: isDarkMode ? darkSecondary : lightSecondary,
      onSecondary: isDarkMode ? lightSecondary : darkSecondary,
      surface: isDarkMode ? darkSurface : lightSurface,
      onSurface: isDarkMode ? lightSurface : darkSurface,
      error: isDarkMode ? darkError : lightError,
      onError: Colors.white,
    );
  }
}