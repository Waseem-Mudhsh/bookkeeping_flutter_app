

import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart' show themeDataProvider;

class TimerProgressCard extends ConsumerWidget {
  final DateTime startDate;
  final int totalDays;
  
  const TimerProgressCard({
    super.key,
    required this.startDate,
    required this.totalDays,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.watch(responsiveProvider);
    final theme = ref.watch(themeDataProvider);
    final now = DateTime.now();
    final endDate = startDate.add(Duration(days: totalDays));
    final isExpired = now.isAfter(endDate);
    final remainingDays = isExpired 
        ? 0 
        : endDate.difference(now).inDays + 1;
    
    final progress = isExpired ? 1.0 : 1 - (remainingDays / totalDays);

    return Padding(
      padding: responsive.paddingSym(h: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation(
              isExpired ?theme.colorScheme.error : theme.colorScheme.primary,
            ),
          ),
          ResponsiveSpace(height: 8),
          CustomAutoSizeText(
           text:  isExpired 
                ? 'أنتهت المدة ${DateFormat.yMd().format(endDate)}'
                : '$remainingDays متبقى (${DateFormat.yMd().format(endDate)}) يوم',
            style: theme.textTheme.bodySmall,
            colorText: isExpired ? theme.colorScheme.error : null,

          ),
        ],
      ),
    );
  }
}