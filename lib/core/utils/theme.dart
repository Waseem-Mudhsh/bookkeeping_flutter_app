import 'package:bookkeeping_flutter_app/core/providers/responsive_notifier.dart';
import 'package:flutter/material.dart';

import 'add_color.dart';

class AppTheme {
  static ThemeData getTheme(ResponsiveValues responsive, bool isDarkMode) {
    final colorScheme = AppColors.getColorScheme(isDarkMode);

    return ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor:
          isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      // ===== Responsive Color Scheme =====
      colorScheme: colorScheme,

      // ===== Responsive Typography =====
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: responsive.sp(96)),
        displayMedium: TextStyle(fontSize: responsive.sp(60)),
        // ... All other text styles with responsive sizing
        bodyLarge: TextStyle(fontSize: responsive.sp(18)),
        bodyMedium: TextStyle(fontSize: responsive.sp(16)),
        bodySmall: TextStyle(fontSize: responsive.sp(12)),
        labelSmall: TextStyle(fontSize: responsive.sp(10)),
      ).apply(fontFamily: 'Cairo',
      ),
    );
  }
}
