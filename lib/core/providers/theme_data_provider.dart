// 📌 تعريف `AppTheme` لتوحيد إدارة الثيم

import 'package:bookkeeping_flutter_app/core/providers/responsive_notifier.dart';
import 'package:bookkeeping_flutter_app/core/providers/settings_provider.dart';
import 'package:bookkeeping_flutter_app/core/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// 📌 `Provider` لإرجاع `ThemeData` بناءً على الثيم الحالي
class ThemeDataProvider extends Notifier<ThemeData> {
  @override
  ThemeData build() {
    final responsiveValues = ref.watch(responsiveProvider);
    final settings = ref.watch(settingsProvider);
    final isDark = settings['isDarkMode'] ?? false; // Watch dark mode state

    return AppTheme.getTheme(responsiveValues, isDark);
  }
}

final themeDataProvider = NotifierProvider<ThemeDataProvider, ThemeData>(() => ThemeDataProvider());
