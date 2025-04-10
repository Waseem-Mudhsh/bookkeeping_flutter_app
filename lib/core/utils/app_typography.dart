import 'package:bookkeeping_flutter_app/core/providers/responsive_notifier.dart';
import 'package:bookkeeping_flutter_app/core/utils/add_color.dart';
import 'package:flutter/material.dart';

class AppTypography {
  static TextTheme getTextTheme(ResponsiveValues responsive, bool isDarkMode) {
    return TextTheme(
      displayLarge: TextStyle(fontSize: responsive.sp(96)),
      displayMedium: TextStyle(fontSize: responsive.sp(60)),
      bodyLarge: TextStyle(fontSize: responsive.sp(18)),
      bodyMedium: TextStyle(fontSize: responsive.sp(16)),
      bodySmall: TextStyle(fontSize: responsive.sp(12)),
    ).apply(
      fontFamily: 'Cairo',
      bodyColor: isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary,
      displayColor: isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary,
    );
  }
}