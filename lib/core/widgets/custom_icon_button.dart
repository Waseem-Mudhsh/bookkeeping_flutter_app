// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/responsive_notifier.dart';
import '../providers/theme_data_provider.dart';

class CustomIconButton extends ConsumerWidget {
  final VoidCallback onPressed;
  final Icon icon;

  final Color? iconColor;
  final double? iconSize;
  final Color? backgroundColor;

  const CustomIconButton({
    super.key,

    required this.onPressed,
    required this.icon,

    this.iconColor,
    this.iconSize,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final responsive = ref.watch(responsiveProvider);

    return IconButton(
      padding: responsive.paddingAll(8),
      onPressed: onPressed,
      icon: Icon(
        icon.icon,
        size:   responsive.w(iconSize ??24),
        color: iconColor ?? theme.colorScheme.onPrimaryFixed,
        semanticLabel: icon.semanticLabel,
      ),
      tooltip: icon.semanticLabel,
      
      style: backgroundColor != null ? IconButton.styleFrom(
        backgroundColor: backgroundColor!.withAlpha( 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(responsive.w(55)),
        ),

      ): null,
    );
  }
}
