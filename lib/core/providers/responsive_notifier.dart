import 'package:bookkeeping_flutter_app/core/providers/device_size_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



// 📌 كائن يحتوي على القيم المتجاوبة
class ResponsiveValues {
  final Size deviceSize;
  
  final Orientation orientation;
  // أبعاد التصميم الأساسية (افتراضية لتطبيق جوال)
  static const double _designWidth = 360.0;
  static const double _designHeight = 812.0;
  static const double _minScale = 0.8;
  static const double _maxScale = 1.5;


  ResponsiveValues({
    required this.deviceSize,
    required this.orientation,
  });
  /// حساب نسبة العرض (للمكونات الأفقية)
  double get widthRatio => deviceSize.width / _designWidth;

  /// حساب نسبة الارتفاع (للمكونات الرأسية)
  double get heightRatio => deviceSize.height / _designHeight;

   /// حساب النسبة بناءً على أقصر جانب (للنصوص والعناصر المربعة)
  double get scaleFactor => 
      (deviceSize.shortestSide / _designWidth);

double w(double value) => (value * scaleFactor.clamp(_minScale, _maxScale));
  double h(double value) => (value * scaleFactor.clamp(_minScale, _maxScale));
  double sp(double value) => (value * scaleFactor.clamp(_minScale, _maxScale));
  double p(double value) => w(value);
  
  EdgeInsets paddingAll(double value) => EdgeInsets.all(p(value));
  
  EdgeInsets paddingSym({double h = 0, double v = 0}) => 
      EdgeInsets.symmetric(horizontal: p(h), vertical: p(v));
}

// 📌 `Notifier` لإدارة القيم المتجاوبة
class ResponsiveNotifier extends Notifier<ResponsiveValues> {
  @override
  ResponsiveValues build() {
    // final size = MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.first).size;
    final size = ref.watch(deviceSizeProvider);
    final orientation = size.width > size.height ? Orientation.landscape : Orientation.portrait;
    print('Size: ${size.width} x ${size.height}');
    
    
    return ResponsiveValues(
      deviceSize: size,
     
      orientation: orientation,
    );
  }
}

// 📌 مزود `NotifierProvider` للكائن المتجاوب
final responsiveProvider = NotifierProvider<ResponsiveNotifier, ResponsiveValues>(() => ResponsiveNotifier());
