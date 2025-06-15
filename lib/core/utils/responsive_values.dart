import 'package:bookkeeping_flutter_app/core/providers/responsive_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/design_constants.dart';

class ResponsiveValues {
  final Size deviceSize;
  final Orientation orientation;

  ResponsiveValues({required this.deviceSize, required this.orientation});

  /// حساب نسبة العرض (للمكونات الأفقية)
  double get widthRatio => deviceSize.width / DesignConstants.designWidth;

  /// حساب نسبة الارتفاع (للمكونات الرأسية)
  double get heightRatio => deviceSize.height / DesignConstants.designHeight;

  /// حساب النسبة بناءً على أقصر جانب (للنصوص والعناصر المربعة)
  double get scaleFactor =>
      (deviceSize.shortestSide / DesignConstants.designWidth);

  double w(double value) =>
      (value *
          scaleFactor.clamp(
            DesignConstants.minScale,
            DesignConstants.maxScale,
          ));
  double h(double value) =>
      (value *
          scaleFactor.clamp(
            DesignConstants.minScale,
            DesignConstants.maxScale,
          ));
  double sp(double value) =>
      (value *
          scaleFactor.clamp(
            DesignConstants.minScale,
            DesignConstants.maxScale,
          ));
  double p(double value) => w(value);

  EdgeInsets paddingAll(double value) => EdgeInsets.all(p(value));
  EdgeInsets paddingOnly({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) =>
      EdgeInsets.only(
        left: p(left),
        right: p(right),
        top: p(top),
        bottom: p(bottom),
      );

  EdgeInsets paddingSym({double h = 0, double v = 0}) =>
      EdgeInsets.symmetric(horizontal: p(h), vertical: p(v));

     
}
  
extension ResponsiveRefExtension on WidgetRef {
  double sp(double value) => watch(responsiveProvider.select((r) => r.sp(value)));
  double w(double value) => watch(responsiveProvider.select((r) => r.w(value)));
  double h(double value) => watch(responsiveProvider.select((r) => r.h(value)));
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

