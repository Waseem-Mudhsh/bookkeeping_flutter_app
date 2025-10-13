import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomNotificationButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final int notificationCount;

  const CustomNotificationButton({
    super.key,
    this.onPressed,
    this.notificationCount = 0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    return Stack(
      clipBehavior: Clip.none,
      
      children: [
        IconButton(
          icon:  CustomHugeIcon(icon: HugeIcons.strokeRoundedNotification01),
          onPressed: onPressed,
        ),
        if (notificationCount > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: CustomAutoSizeText(
               text:  '$notificationCount',
                style:  theme.textTheme.bodySmall,
                fontSize: 10,
                colorText: theme.colorScheme.onPrimaryContainer,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}