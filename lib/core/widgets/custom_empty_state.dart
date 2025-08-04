import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CustomEmptyState extends ConsumerWidget {
  final String message;
  final String? subMessage;
  final IconData? icon;
  final ThemeData theme;
  const CustomEmptyState({
    super.key,
   required this.message,
    this.subMessage,
    this.icon,
   required this.theme,
  });
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Icon(icon ?? Icons.people_alt_outlined, size: 64, color: Colors.grey),
          const ResponsiveSpace(height: 16),
          CustomAutoSizeText(
          text:  message,
          colorText: theme.colorScheme.onSurface,
          style: theme.textTheme.headlineSmall,
          textAlign: TextAlign.center,
           maxLines: 3,
          ),
          const ResponsiveSpace(height: 8),
          CustomAutoSizeText(
            text: subMessage ?? '',
            textAlign: TextAlign.center,
            colorText: theme.colorScheme.onSurfaceVariant,
            style: theme.textTheme.bodySmall,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}