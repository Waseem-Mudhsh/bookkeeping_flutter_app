//
// File: lib/presentation/account/widgets/transaction_list_item.dart
//
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';
import '../../../../core/widgets/responsive_space.dart';
import '../../domain/entities/transaction.dart';


// This widget is responsible for a single transaction list item.
class TransactionListItem extends ConsumerWidget {
  final Transaction transaction;
  final String currencySymbol;

  const TransactionListItem({
    super.key,
    required this.transaction,
    required this.currencySymbol,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final responsive = ref.watch(responsiveProvider);
    final isDebit = transaction.amount < 0;

    return Card(
      elevation: 2,
      margin: responsive.paddingOnly(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(responsive.w(12))),
      child: ListTile(
        contentPadding: responsive.paddingSym(h: 16, v: 8),
        leading: Icon(
          isDebit ? Icons.arrow_upward : Icons.arrow_downward,
          color: isDebit ? Colors.red.shade600 : Colors.green.shade600,
        ),
        title: Text(
          transaction.description,
          style: theme.textTheme.titleMedium,
        ),
        subtitle: Text(
          DateFormat('dd MMMM, yyyy - hh:mm a').format(transaction.date),
          style: theme.textTheme.bodySmall,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$currencySymbol ${transaction.amount.toStringAsFixed(2)}',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDebit ? Colors.red.shade600 : Colors.green.shade600,
              ),
            ),
            ResponsiveSpace(height: responsive.h(4)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => debugPrint('Edit transaction: ${transaction.id}'),
                  icon: Icon(Icons.edit_outlined, size: responsive.w(18), color: theme.colorScheme.onSurfaceVariant),
                  tooltip: 'تعديل',
                ),
                IconButton(
                  onPressed: () => debugPrint('Delete transaction: ${transaction.id}'),
                  icon: Icon(Icons.delete_outlined, size: responsive.w(18), color: Colors.red),
                  tooltip: 'حذف',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}