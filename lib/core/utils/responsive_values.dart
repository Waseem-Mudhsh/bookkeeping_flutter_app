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

  EdgeInsets paddingAll(num value) => EdgeInsets.all(p(value.toDouble()));
  EdgeInsets paddingOnly({
    num left = 0.0,
    num right = 0.0,
    num top = 0.0,
    num bottom = 0.0,
  }) =>
      EdgeInsets.only(
        left: p(left.toDouble()),
        right: p(right.toDouble()),
        top: p(top.toDouble()),
        bottom: p(bottom.toDouble()),
      );

  EdgeInsets paddingSym({num h = 0.0, num v = 0.0}) =>
      EdgeInsets.symmetric(horizontal: p(h.toDouble()), vertical: p(v.toDouble()));

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
  
