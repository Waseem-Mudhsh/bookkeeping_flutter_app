import 'package:flutter/material.dart';

import '../constants/design_constants.dart';

class ResponsiveValues {
  final Size deviceSize;
  final Orientation orientation;

  ResponsiveValues({required this.deviceSize, required this.orientation});

  

  // /// حساب النسبة بناءً على أقصر جانب (للنصوص والعناصر المربعة)
  // double get scaleFactor =>
  //     (deviceSize.shortestSide / DesignConstants.designWidth);

  double w(double value) =>
      (value *
          scaleFactor.clamp(
            minScale,
            maxScale,
          ));
  double h(double value) =>
      (value *
          scaleFactor.clamp(
            minScale,
            maxScale,
          ));
  double sp(double value) =>
      (value *
          scaleFactor.clamp(
           minScale,
            maxScale,
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

 double get designWidth {
    if (deviceSize.shortestSide > DesignConstants.designWidthDesktop) {
      return DesignConstants.designWidthDesktop;
    } else if (deviceSize.shortestSide > DesignConstants.designWidthTablet) {
      return DesignConstants.designWidthTablet;
    } else {
      return DesignConstants.designWidthMobile;
    }
  }

  double get minScale {
    if (deviceSize.shortestSide > DesignConstants.designWidthDesktop) {
      return DesignConstants.minScaleDesktop;
    } else if (deviceSize.shortestSide > DesignConstants.designWidthTablet) {
      return DesignConstants.minScaleTablet;
    } else {
      return DesignConstants.minScaleMobile;
    }
  }

  double get maxScale {
    if (deviceSize.shortestSide > DesignConstants.designWidthDesktop) {
      return DesignConstants.maxScaleDesktop;
    } else if (deviceSize.shortestSide > DesignConstants.designWidthTablet) {
      return DesignConstants.maxScaleTablet;
    } else {
      return DesignConstants.maxScaleMobile;
    }
  }

  double get scaleFactor =>
      (deviceSize.shortestSide / designWidth);
     
}
  
