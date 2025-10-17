import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/notification_model.dart';

// بيانات وهمية أولية للإشعارات
final List<NotificationModel> _initialMockNotifications = [
  NotificationModel(
    id: 'al1',
    message: 'رصيد العميل محمد تجاوز الحد المسموح به!',
    type: NotificationType.warning,
    onPressed: () => debugPrint('Top up cash'),
    date: DateTime.now(),
  ),
  NotificationModel(
    id: 'al2',
    message: 'تمت إضافة حساب جديد: محمد علي',
    type: NotificationType.info,
    onPressed: () => debugPrint('Pay electricity bill'),
  ),
  NotificationModel(
    id: 'al3',
    message: 'تنبيه أمني: تم تسجيل دخول من جهاز جديد.',
    type: NotificationType.critical,
    onPressed: () => debugPrint('Review security settings'),
    date: DateTime.now().subtract(const Duration(hours: 2)),
  ),
];

/// Notifier لإدارة قائمة الإشعارات
class NotificationNotifier extends StateNotifier<List<NotificationModel>> {
  NotificationNotifier() : super(_initialMockNotifications);

  /// دالة لحذف إشعار من القائمة بناءً على الـ id
  void removeNotification(String notificationId) {
    // إنشاء قائمة جديدة بدون الإشعار الذي تم حذفه
    state = state.where((notification) => notification.id != notificationId).toList();
  }

  /// دالة لإعادة تعيين الإشعارات (لأغراض الاختبار)
  void resetNotifications() {
    state = _initialMockNotifications;
  }

  int get notificationCount => state.length;
}

/// Provider الذي سيوفر الـ Notifier لواجهات المستخدم
final notificationProvider = StateNotifierProvider<NotificationNotifier, List<NotificationModel>>((ref) {
  return NotificationNotifier();
});
