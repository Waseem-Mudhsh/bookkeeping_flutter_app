import 'package:bookkeeping_flutter_app/core/providers/device_size_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 📌 قيم التصميم الأصلية
const double designWidth = 360;
const double designHeight = 690;
const double minScale = 0.8;
const double maxScale = 1.5;

// 📌 كائن يحتوي على القيم المتجاوبة
class ResponsiveValues {
  final double widthFactor;
  final double heightFactor;
  final double screenWidth;
  final double screenHeight;

  ResponsiveValues({
    required this.widthFactor,
    required this.heightFactor,
    required this.screenWidth,
    required this.screenHeight,
  });

double w(double value) => (value * widthFactor.clamp(minScale, maxScale));
  double h(double value) => (value * heightFactor.clamp(minScale, maxScale));
  double sp(double value) => (value * widthFactor.clamp(minScale, maxScale));
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
    print('Size: ${size.width} x ${size.height}');
    return ResponsiveValues(
      widthFactor: size.width / designWidth,
      heightFactor: size.height / designHeight,
      screenWidth: size.width,
      screenHeight: size.height,
    );
  }
}

// 📌 مزود `NotifierProvider` للكائن المتجاوب
final responsiveProvider = NotifierProvider<ResponsiveNotifier, ResponsiveValues>(() => ResponsiveNotifier());
