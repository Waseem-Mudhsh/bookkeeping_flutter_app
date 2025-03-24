// import 'package:flutter/material.dart';

// final ThemeData lightTheme = ThemeData(
//   brightness: Brightness.light,
//   primarySwatch: Colors.blue,
//   visualDensity: VisualDensity.adaptivePlatformDensity,
// );

// final ThemeData darkTheme = ThemeData(
//   brightness: Brightness.dark,
//   primarySwatch: Colors.blue,
//   visualDensity: VisualDensity.adaptivePlatformDensity,
// );
import 'package:flutter/material.dart';

import 'add_color.dart';
import 'add_text_style.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      // Primary Color
      primaryColor: AppColors.primary,
      primarySwatch: AppColors.primarySwatch,

      // Text Theme
      textTheme: const TextTheme(
        headlineSmall: AppTextStyles.headline,
        displayLarge: AppTextStyles.bodyText1,
        displayMedium: AppTextStyles.bodyText2,
        displaySmall: AppTextStyles.button,
        labelSmall: AppTextStyles.caption,
      ),

      // Button Theme
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.primary,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        color: AppColors.primary,
        titleTextStyle: AppTextStyles.bodyText1,
      ),
    );
  }
}