import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/theme_data_provider.dart';

class CustomerEmptyState extends ConsumerWidget {
  const CustomerEmptyState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.people_alt_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'لا يوجد عملاء',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'يمكنك إضافة عملاء جدد من خلال زر الإضافة في الزاوية العليا اليمنى',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}