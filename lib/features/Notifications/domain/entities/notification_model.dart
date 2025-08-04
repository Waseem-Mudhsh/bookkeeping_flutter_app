import 'package:flutter/material.dart';

class NotificationModel {
  final String id;
  final String message;
  final NotificationType type;
  final DateTime? date;
  final VoidCallback? onPressed; // Action to take when alert is tapped

  NotificationModel({
    required this.id,
    required this.message,
    required this.type,
    this.date,
    this.onPressed,
  });
}

enum NotificationType { warning, info, critical }

