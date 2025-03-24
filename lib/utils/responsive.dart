// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class Responsive {
//   static double? _screenWidth;
//   static double? _designWithSize;
//   static double? _designHeightSize;
//   static double? _designFontSize;
//   static double? _scalingFactor;
  
//   static void init(BuildContext context) {
//     ScreenUtil.init(
//       context,
//       designSize: const Size(360, 690), // Default design size (mobile)
//       minTextAdapt: true,
//       splitScreenMode: true,
//     );
//     _designWithSize = 360;
//     _designHeightSize = 690;
//     _screenWidth = MediaQuery.of(context).size.width;
//     _scalingFactor = _screenWidth! / _designWithSize!;
//   }

//   static bool isMobile(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context); // Use MediaQuery directly

//     double devicePixelRatio = mediaQuery.devicePixelRatio;
//     double deviceWidth = mediaQuery.size.width;
    

//     TextScaler textScaleFactor = mediaQuery.textScaler;
//   print('devicePixelRatio: $devicePixelRatio');
//   print('deviceWidth: $deviceWidth');
//   print('Text Scale Factor: $textScaleFactor');
  
//     return mediaQuery.size.width < 600;
//   }


//   static bool isTablet(BuildContext context) =>
//       MediaQuery.of(context).size.width >= 600 &&
//       MediaQuery.of(context).size.width < 1200;


//   static bool isDesktop(BuildContext context) =>
//       MediaQuery.of(context).size.width >= 1200;

//   // static double responsiveWidth(double width) => width.w;

//   static double responsiveHeight(double height) => height.h;

//   // static double responsiveFontSize(double fontSize) => fontSize.sp;

// static double responsiveFontSize(BuildContext context, double fontSize) {
 
//   print('Scaling Factor/360: $_scalingFactor\n');
//   return fontSize * _scalingFactor!;
// }
// static double responsiveWidth(BuildContext context, double width) {
//   // Return the scaled width
//   return width * _scalingFactor!;
// }
// }




import 'package:flutter/material.dart';

class Responsive {
  // Design dimensions (e.g., from Figma)
  static const double designWidth = 360; // Design width for mobile
  static const double designHeight = 690; // Design height for mobile

  // Min and max scaling limits (optional)
  static const double minScale = 0.8; // Minimum scaling factor
  static const double maxScale = 1.5; // Maximum scaling factor

  // Get the screen width
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // Get the screen height
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Check if the device is in portrait mode
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  // Check if the device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  // Scale width based on screen width
  static double responsiveWidth(BuildContext context, double width) {
    // final double screenWidth = MediaQuery.of(context).size.width;
    final double scalingFactor = screenWidth(context) / designWidth;

    // Apply min/max scaling limits
    final double scaledWidth = width * scalingFactor.clamp(minScale, maxScale);

    return scaledWidth;
  }

  // Scale height based on screen height
  static double responsiveHeight(BuildContext context, double height) {
    // final double screenHeight = MediaQuery.of(context).size.height;
    final double scalingFactor = screenHeight(context) / designHeight;

    // Apply min/max scaling limits
    final double scaledHeight = height * scalingFactor.clamp(minScale, maxScale);

    return scaledHeight;
  }

  // Scale font size based on screen width
  static double responsiveFontSize(BuildContext context, double fontSize) {
    // final double screenWidth = MediaQuery.of(context).size.width;
    final double scalingFactor = screenWidth(context) / designWidth;

    // Apply min/max scaling limits
    final double scaledFontSize = fontSize * scalingFactor.clamp(minScale, maxScale);

    return scaledFontSize;
  }

  // Scale padding/margin based on screen width (optional)
  static double responsivePadding(BuildContext context, double padding) {
    final double scaledPadding = responsiveWidth(context, padding);
    return scaledPadding;
  }
}