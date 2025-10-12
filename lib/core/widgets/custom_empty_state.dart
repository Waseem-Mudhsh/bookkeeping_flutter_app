import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';


class CustomEmptyState extends ConsumerWidget {
  final String message;
  final String? subMessage;
  final IconData? icon;
  
  const CustomEmptyState({
    super.key,
   required this.message,
    this.subMessage,
    this.icon,
   
  });
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme= ref.theme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           CustomHugeIcon(icon:  icon ?? HugeIcons.strokeRoundedUserAdd02, size: 64, color: Colors.grey),
          const ResponsiveSpace(height: 16),
          CustomAutoSizeText(
          text:  message,
          colorText: theme.colorScheme.onSurface,
          style: theme.textTheme.bodyMedium,
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