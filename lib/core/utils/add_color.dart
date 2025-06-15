import 'package:flutter/material.dart';

class AppColors {
  // Light Mode Colors
  static const Color lightPrimary = Color(0xFF3D455A); // #03DAC6
  static const Color lightSecondary = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFFBFBFB); //#F5F5F5
  static const Color lightError = Color(0xFFDC3545);
  static const Color lightAccent = Color(0xFF28A745);
  static const Color lightTertiary = Color(0xFFC2C8D6);
  

  // Dark Mode Colors
  static const Color darkPrimary = Color(0xFFFFFFFF);
  static const Color darkSecondary = Color(0xFF3D455A);
  static const Color darkSurface = Color(0xFF525E7A);
  static const Color darkError = Color(0xFFDC3545);
  static const Color darkAccent = Color(0xFF28A745);
  static const Color darkTertiary = Color(0xFF8591AD);

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
      tertiary: isDarkMode ? darkTertiary : lightTertiary,
      onTertiary: isDarkMode ? lightTertiary : darkTertiary,
    );
  }
}
/// Light [ColorScheme] made with FlexColorScheme v8.2.0.
/// Requires Flutter 3.22.0 or later.
const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF0061A4),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFD1E4FF),
  onPrimaryContainer: Color(0xFF000000),
  primaryFixed: Color(0xFFBFDFF4),
  primaryFixedDim: Color(0xFF8CC0E5),
  onPrimaryFixed: Color(0xFF001C2F),
  onPrimaryFixedVariant: Color(0xFF002741),
  secondary: Color(0xFF006781),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFB9EAFF),
  onSecondaryContainer: Color(0xFF000000),
  secondaryFixed: Color(0xFFBFE3ED),
  secondaryFixedDim: Color(0xFF8CCADA),
  onSecondaryFixed: Color(0xFF001216),
  onSecondaryFixedVariant: Color(0xFF002029),
  tertiary: Color(0xFFA73A00),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFDBCE),
  onTertiaryContainer: Color(0xFF000000),
  tertiaryFixed: Color(0xFFF5D2BF),
  tertiaryFixedDim: Color(0xFFE6AC8C),
  onTertiaryFixed: Color(0xFF311100),
  onTertiaryFixedVariant: Color(0xFF431700),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFFDAD6),
  onErrorContainer: Color(0xFF000000),
  surface: Color(0xFFFCFCFC),
  onSurface: Color(0xFF111111),
  surfaceDim: Color(0xFFE0E0E0),
  surfaceBright: Color(0xFFFDFDFD),
  surfaceContainerLowest: Color(0xFFFFFFFF),
  surfaceContainerLow: Color(0xFFF8F8F8),
  surfaceContainer: Color(0xFFF3F3F3),
  surfaceContainerHigh: Color(0xFFEDEDED),
  surfaceContainerHighest: Color(0xFFE7E7E7),
  onSurfaceVariant: Color(0xFF393939),
  outline: Color(0xFF919191),
  outlineVariant: Color(0xFFD1D1D1),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFF2A2A2A),
  onInverseSurface: Color(0xFFF1F1F1),
  inversePrimary: Color(0xFF99DAFF),
  surfaceTint: Color(0xFF0061A4),
);

/// Dark [ColorScheme] made with FlexColorScheme v8.2.0.
/// Requires Flutter 3.22.0 or later.
const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF9ECAFF),
  onPrimary: Color(0xFF000000),
  primaryContainer: Color(0xFF00497D),
  onPrimaryContainer: Color(0xFFFFFFFF),
  primaryFixed: Color(0xFFBFDFF4),
  primaryFixedDim: Color(0xFF8CC0E5),
  onPrimaryFixed: Color(0xFF001C2F),
  onPrimaryFixedVariant: Color(0xFF002741),
  secondary: Color(0xFF86D1EE),
  onSecondary: Color(0xFF000000),
  secondaryContainer: Color(0xFF004D62),
  onSecondaryContainer: Color(0xFFFFFFFF),
  secondaryFixed: Color(0xFFBFE3ED),
  secondaryFixedDim: Color(0xFF8CCADA),
  onSecondaryFixed: Color(0xFF001216),
  onSecondaryFixedVariant: Color(0xFF002029),
  tertiary: Color(0xFFFFB599),
  onTertiary: Color(0xFF000000),
  tertiaryContainer: Color(0xFF802A00),
  onTertiaryContainer: Color(0xFFFFFFFF),
  tertiaryFixed: Color(0xFFF5D2BF),
  tertiaryFixedDim: Color(0xFFE6AC8C),
  onTertiaryFixed: Color(0xFF311100),
  onTertiaryFixedVariant: Color(0xFF431700),
  error: Color(0xFFFFB4AB),
  onError: Color(0xFF000000),
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFFFFF),
  surface: Color(0xFF080808),
  onSurface: Color(0xFFF1F1F1),
  surfaceDim: Color(0xFF060606),
  surfaceBright: Color(0xFF2C2C2C),
  surfaceContainerLowest: Color(0xFF010101),
  surfaceContainerLow: Color(0xFF0E0E0E),
  surfaceContainer: Color(0xFF151515),
  surfaceContainerHigh: Color(0xFF1D1D1D),
  surfaceContainerHighest: Color(0xFF282828),
  onSurfaceVariant: Color(0xFFCACACA),
  outline: Color(0xFF777777),
  outlineVariant: Color(0xFF414141),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFFE8E8E8),
  onInverseSurface: Color(0xFF2A2A2A),
  inversePrimary: Color(0xFF495B6B),
  surfaceTint: Color(0xFF9ECAFF),
);
