import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_empty_state.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/features/Notifications/presentation/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/widgets/custom_auto_size_text.dart';
import '../../../../core/widgets/responsive_space.dart';
import '../../domain/entities/notification_model.dart' as model;

class NotificationSection extends ConsumerWidget {
  const NotificationSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationProvider);
    final responsive = ref.responsive;
    final theme = ref.theme;

    if (notifications.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: CustomEmptyState(
            icon: HugeIcons.strokeRoundedNotificationOff01,
            message: 'لا توجد إشعارات',
            subMessage: 'سيتم عرض الإشعارات الجديدة هنا.',
          ),
        ),
      );
    }

    return SliverList.separated(
      itemCount: notifications.length,
      separatorBuilder: (context, index) => const ResponsiveSpace(height: 8),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return Dismissible(
          key: Key(notification.id),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            // استدعاء دالة الحذف من الـ provider
            ref.read(notificationProvider.notifier).removeNotification(notification.id);

            // إظهار رسالة تأكيد
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                 SnackBar(content: CustomAutoSizeText(text:  'تم حذف الإشعار',
                 style: theme.textTheme.bodySmall,
                 colorText: theme.colorScheme.onPrimary,
                 fontSize: 10,
                 ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: theme.colorScheme.primary,
                ),
              );
          },
          background: Container(
            decoration: BoxDecoration(
              color: ref.theme.colorScheme.error,
              borderRadius: BorderRadius.circular(responsive.w(12)),
            ),
            alignment: Alignment.centerRight,
            padding: responsive.paddingSym(h: 20),
            child: const CustomHugeIcon(icon: HugeIcons.strokeRoundedDelete02, color: Colors.white),
          ),
          child: _NotificationItemCard(notification: notification),
        );
      },
    );
  }
}

class _NotificationItemCard extends ConsumerWidget {
  final model.NotificationModel notification;

  const _NotificationItemCard({required this.notification});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final responsive = ref.responsive;

    Color notificationColor;
    IconData notificationIcon;

    switch (notification.type) {
      case model.NotificationType.critical:
        notificationColor = theme.colorScheme.error;
        notificationIcon = HugeIcons.strokeRoundedSettingsError01;
        break;
      case model.NotificationType.warning:
        notificationColor = Colors.orange.shade600;
        notificationIcon = HugeIcons.strokeRoundedAlert01;
        break;
      case model.NotificationType.info:
        notificationColor = theme.colorScheme.primary;
        notificationIcon = HugeIcons.strokeRoundedAlertCircle;
        break;
    }

    return InkWell(
      onTap: notification.onPressed,
      borderRadius: BorderRadius.circular(responsive.w(12)),
      child: Container(
        padding: responsive.paddingSym(h: 16, v: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(responsive.w(12)),
          border: Border(
            right: BorderSide(color: notificationColor, width: 4),
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomHugeIcon(
              icon: notificationIcon,
              color: notificationColor,
              size: 24,
            ),
            const ResponsiveSpace(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAutoSizeText(
                    text: notification.message,
                    style: theme.textTheme.bodyMedium,
                    fontWeight: FontWeight.w600,
                    colorText: theme.colorScheme.onSurface,
                    fontSize: 12,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (notification.date != null) ...[
                    const ResponsiveSpace(height: 4),
                    CustomAutoSizeText(
                      text: 'تاريخ: ${notification.date!.day}/${notification.date!.month}',
                      style: theme.textTheme.bodySmall,
                      colorText: theme.colorScheme.onSurfaceVariant,
                      fontSize: 10,
                    ),
                  ]
                ],
              ),
            ),
            if (notification.onPressed != null)
              CustomHugeIcon(
                icon: HugeIcons.strokeRoundedArrowLeft01,
                color: theme.colorScheme.onSurfaceVariant,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}
