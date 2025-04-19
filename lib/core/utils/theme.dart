import 'package:bookkeeping_flutter_app/core/utils/app_typography.dart';
import 'package:flutter/material.dart';

import 'add_color.dart';
import 'responsive_values.dart';

class AppTheme {
  static ThemeData getTheme(ResponsiveValues responsive, bool isDarkMode) {
    final colorScheme = AppColors.getColorScheme(isDarkMode);

    return ThemeData(
      useMaterial3: false,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.secondary,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        titleTextStyle: TextStyle(
          fontFamily: 'Cairo',
          fontSize: responsive.sp(16),
          fontWeight: FontWeight.bold,
          color: colorScheme.onPrimary,
        ),
      ),
      textTheme: AppTypography.getTextTheme(responsive, isDarkMode),
    );
  }
}
