// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/responsive_notifier.dart';
import '../providers/theme_data_provider.dart';

class CustomIconbutton extends ConsumerWidget {
  final VoidCallback onPressed;
  final Icon icon;

  final Color? iconColor;
  final double? iconSize;

  const CustomIconbutton({
    super.key,

    required this.onPressed,
    required this.icon,

    this.iconColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final responsive = ref.watch(responsiveProvider);

    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon.icon,
        size: iconSize ?? responsive.w(24),
        color: iconColor ?? theme.colorScheme.primary,
      ),
    );
  }
}
