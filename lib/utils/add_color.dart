import 'package:flutter/material.dart';

class AppColors {
  // Primary Color (#3D455A)
  static const Color primary = Color(0xFF3D455A);

  // Primary Color Swatch (Shades of #3D455A)
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF3D455A,
    <int, Color>{
      50: Color(0xFFE8E9EB),
      100: Color(0xFFC5C7CC),
      200: Color(0xFF9FA2AD),
      300: Color(0xFF797D8E),
      400: Color(0xFF5C6176),
      500: Color(0xFF3D455A),
      600: Color(0xFF373E51),
      700: Color(0xFF2F3648),
      800: Color(0xFF272E3F),
      900: Color(0xFF1A1F2E),
    },
  );

  // Secondary Colors (Optional)
  static const Color secondary = Color(0xFF6C757D);
  static const Color accent = Color(0xFF28A745);
  static const Color error = Color(0xFFDC3545);
}