import 'package:flutter/material.dart';

class AppColors {
  // Primary Color (#3D455A)
  // static const Color primary = Color(0xFF3D455A);

  static const Color lightPrimary = Color(0xFF3D455A); //Buttons, App bars
  static const Color lightSecondary = Color(0xFFFFFFFF); // secondary Buttons
  static const Color lightSurface = Color(0xFFF8F9FA,); // color for cards, sheets, and dialogs
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightError = Color(0xFFDC3545);
  static const Color lightAccent = Color(0xFF28A745);

  // Dark Mode Colors
  static const Color darkPrimary = Color(0xFFFFFFFF);
  static const Color darkSecondary = Color(0xFF3D455A);
  static const Color darkSurface = Color(0xFF121212);
  static const Color darkBackground = Color(0xFF3D455A);
  static const Color darkError = Color(0xFFCF6679);
  static const Color darkAccent = Color(0xFF28A745);

  static ColorScheme getColorScheme(bool isDarkMode) {
    return ColorScheme(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primary: isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary,
      onPrimary:
          isDarkMode
              ? AppColors.lightPrimary
              : AppColors.darkPrimary, // Text/icon color on primary

      secondary:
          isDarkMode ? AppColors.darkSecondary : AppColors.lightSecondary,
      onSecondary:
          isDarkMode ? AppColors.lightSecondary : AppColors.darkSecondary,

      surface: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
      onSurface: isDarkMode ? AppColors.lightSurface : AppColors.darkSurface,

      error: isDarkMode ? AppColors.darkError : AppColors.lightError,
      onError: Colors.white,
    );
  }
}
