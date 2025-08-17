import 'package:bookkeeping_flutter_app/core/utils/responsive_values.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../providers/theme_data_provider.dart';
import '../providers/responsive_notifier.dart';

extension RefExtensions on WidgetRef {
  ThemeData get theme => watch(themeDataProvider);
  ResponsiveValues get responsive => watch(responsiveProvider);
}