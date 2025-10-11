import 'package:flutter/material.dart';

import 'responsive_values.dart';

class AppTypography {
  static TextTheme getTextTheme(ResponsiveValues responsive, bool isDarkMode) {
    return TextTheme(
      displayLarge: TextStyle(fontSize: responsive.sp(96)),
      displayMedium: TextStyle(fontSize: responsive.sp(60)),
      bodyLarge: TextStyle(fontSize: responsive.sp(14), fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: responsive.sp(12), fontWeight: FontWeight.w600),
      bodySmall: TextStyle(fontSize: responsive.sp(10)),
    ).apply(
      // fontFamily: 'cairo',
      // bodyColor: isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary,
      // displayColor: isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary,
    );
  }
}