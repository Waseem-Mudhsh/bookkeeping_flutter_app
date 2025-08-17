// import 'package:bookkeeping_flutter_app/core/utils/app_typography.dart';
// import 'package:flutter/material.dart';

// import 'add_color.dart';
// import 'responsive_values.dart';

// class AppTheme {
//   static ThemeData getTheme(ResponsiveValues responsive, bool isDarkMode) {
//     final colorScheme = AppColors.getColorScheme(isDarkMode);

//     return ThemeData(
//       useMaterial3: false,
//       colorScheme: colorScheme,
//       scaffoldBackgroundColor: Color( 0xffFFFFFF),
//       appBarTheme: AppBarTheme(
//         backgroundColor: colorScheme.primary,
//         foregroundColor: colorScheme.onPrimary,
//         titleTextStyle: TextStyle(
//           fontFamily: 'Cairo',
//           fontSize: responsive.sp(16),
//           fontWeight: FontWeight.bold,
//           color: colorScheme.onPrimary,
//         ),
//       ),
//       textTheme: AppTypography.getTextTheme(responsive, isDarkMode),
//     );
//   }
// }


import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:bookkeeping_flutter_app/core/utils/app_typography.dart';
import 'package:flutter/material.dart';
import 'responsive_values.dart';


class AppTheme {
  static ThemeData getTheme(ResponsiveValues responsive, bool isDarkMode) {
    if (isDarkMode) {
      return FlexThemeData.dark(
        fontFamily: 'Cairo',
        scaffoldBackground: const Color(0xff161616),
        surfaceMode: FlexSurfaceMode.highScaffoldLevelSurface, // Surface mode
        scheme: FlexScheme.blueM3,
        useMaterial3: true,
        subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      defaultRadius: 4.0,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      elevatedButtonSchemeColor: SchemeColor.onPrimary,
      elevatedButtonSecondarySchemeColor: SchemeColor.primary,// Adjusted height for bottom app bar
      

    ),
    // Direct ThemeData properties.
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    
  
        textTheme: AppTypography.getTextTheme(responsive, isDarkMode),
      );
    } else {
      return FlexThemeData.light(
        fontFamily: 'Cairo',
        scaffoldBackground: const Color(0xffFCFCFC),
        surfaceMode: FlexSurfaceMode.highScaffoldLevelSurface, // Surface mode
        scheme: FlexScheme.blueM3,
        useMaterial3: true,
        
       // Component theme configurations for light mode.
    subThemesData: const FlexSubThemesData(
     
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      defaultRadius: 4.0,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      elevatedButtonSchemeColor: SchemeColor.onPrimary,
      elevatedButtonSecondarySchemeColor: SchemeColor.primary,
      
      
    ),

    // Direct ThemeData properties.
        textTheme: AppTypography.getTextTheme(responsive, isDarkMode),

      );
    }
  }
}
