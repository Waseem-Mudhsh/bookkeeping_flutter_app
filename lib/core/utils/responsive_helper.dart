// ملف: core/utils/responsive_helper.dart
import 'package:flutter/material.dart';

class ResponsiveHelper {
  

  // أبعاد التصميم الأساسية (افتراضية لتطبيق جوال)
  static const double _designWidth = 360.0;
  static const double _designHeight = 812.0;

  
  static double scaleWidth(Size size, double value) {
    return (size.width / _designWidth) * value;
  }

  static double scaleHeight(Size size, double value) {
    return (size.height / _designHeight) * value;
  }

  static double scaleText(Size size, double value) {
    final shortestSide = size.shortestSide;
    return (shortestSide / _designWidth) * value;
  }
  

  /// حجم مستجيب للمكونات (مع تحديد الحدود)
  // double responsiveSize({
  //   required double size,
  //   double? min,
  //   double? max,
  // }) {
  //   final scaledSize = size * scaleFactor;
  //   return scaledSize.clamp(min ?? size * 0.8, max ?? size * 1.5);
  // }

  // /// تحديد عدد الأعمدة في GridView بناءً على الاتجاه
  // int getGridColumnCount({int portrait = 2, int landscape = 3}) {
  //   return orientation == Orientation.portrait ? portrait : landscape;
  // }
}
