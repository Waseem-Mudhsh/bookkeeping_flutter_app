import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
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
    return Badge.count(
      count: notificationCount,
      textColor: theme.colorScheme.onPrimary,
      textStyle: theme.textTheme.bodySmall,
      offset: Offset(-12, 8),
      smallSize: 6,
      largeSize: 10,

      backgroundColor: theme.colorScheme.primary,
      alignment: Alignment.topRight,
      child: IconButton(
        icon: CustomHugeIcon(icon: HugeIcons.strokeRoundedNotification01,
         color: theme.colorScheme.primary,),
        onPressed: onPressed,
      ),
      );
  }
}