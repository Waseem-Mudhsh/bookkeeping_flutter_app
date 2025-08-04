import 'package:flutter/material.dart';

import '../../../../core/utils/responsive_values.dart';
import '../../../../core/widgets/custom_auto_size_text.dart';
import '../../../../core/widgets/responsive_space.dart';
import '../../domain/entities/notification_model.dart' ;

class NotificationSection extends StatelessWidget {
  final List<NotificationModel> mockNotifications;
  final ThemeData theme;
  final ResponsiveValues responsive;

  const NotificationSection({super.key, 
    required this.mockNotifications,
    required this.theme,
    required this.responsive,
  });

  @override
  Widget build(BuildContext context) {
    if (mockNotifications.isEmpty) {
      return const SizedBox.shrink(); // Hide section if no alerts
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAutoSizeText(
          text: 'تنبيهات مهمة',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        ResponsiveSpace(height: responsive.h(12)),
        // Use a ListView.builder with a fixed height or a Horizontal ListView
        // if you want multiple alerts in a horizontal scroll.
        // For simplicity, let's use a Column for vertical display.
        Column(
          children: mockNotifications.map((alert) => _buildNotificationDialog(alert)).toList(),
        ),
      ],
    );
  }


  Widget _buildNotificationDialog(NotificationModel notification) {
    Color notificationColor;
    IconData notificationIcon;
    switch (notification.type) {
      case NotificationType.critical:
        notificationColor = Colors.red.shade400;
        notificationIcon = Icons.error_outline;
        break;
      case NotificationType.warning:
        notificationColor = Colors.orange.shade400;
        notificationIcon = Icons.warning_amber_outlined;
        break;
      case NotificationType.info:
        notificationColor = theme.colorScheme.primary;
        notificationIcon = Icons.info_outline;
        break;
    }

    return Card(
      elevation: 2,
      color: notificationColor.withValues( alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(responsive.w(12))),
      margin: responsive.paddingOnly(bottom: responsive.h(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(responsive.w(12)),
        onTap: notification.onPressed,
        child: Padding(
          padding: responsive.paddingAll(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(notificationIcon, color: notificationColor, size: responsive.w(28)),
              ResponsiveSpace(width: responsive.w(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAutoSizeText(
                      text: notification.message,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (notification.date != null)
                      CustomAutoSizeText(
                        text: 'تاريخ: ${notification.date!.day}/${notification.date!.month}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues( alpha: 0.6),
                        ),
                      ),
                  ],
                ),
              ),
              if (notification.onPressed != null)
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios_outlined, color: notificationColor, size: responsive.w(20)),
                  onPressed: notification.onPressed,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
