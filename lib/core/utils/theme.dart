import 'package:bookkeeping_flutter_app/core/providers/responsive_notifier.dart';
import 'package:bookkeeping_flutter_app/core/utils/app_typography.dart';
import 'package:flutter/material.dart';

import 'add_color.dart';

class AppTheme {
  static ThemeData getTheme(ResponsiveValues responsive, bool isDarkMode) {
    final colorScheme = AppColors.getColorScheme(isDarkMode);

  return ThemeData(
  useMaterial3: false,
  colorScheme: colorScheme,
  scaffoldBackgroundColor: colorScheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: colorScheme.primary,
    foregroundColor: colorScheme.onPrimary,
    titleTextStyle: TextStyle(
      fontFamily: 'Cairo',
      fontSize: responsive.sp(20),
      fontWeight: FontWeight.bold,
      color: colorScheme.onPrimary,
      
    ),

  ),
  textTheme: AppTypography.getTextTheme(responsive, isDarkMode),
);
  }
}
