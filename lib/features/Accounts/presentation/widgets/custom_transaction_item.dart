import 'package:flutter/material.dart';

import '../../../../core/utils/responsive_values.dart';
import '../../../../core/widgets/custom_auto_size_text.dart';
import '../../../../core/widgets/responsive_space.dart';
import '../../../Transactions/domain/entities/transaction.dart';
import '../../../Transactions/domain/entities/transaction_type.dart';

class CustomTransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function(Transaction) onTap;
  final ResponsiveValues responsive;
  final ThemeData theme;
  const CustomTransactionItem({
    super.key,
    required this.transaction,
    required this.onTap,
    required this.responsive,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    
    String sign = transaction.type == TransactionType.debit ? '+' : '-';
    return Card(
      elevation: 2,
      margin: responsive.paddingOnly(bottom: responsive.h(8)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(responsive.w(10)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(responsive.w(10)),
        onTap: () => onTap(transaction),
        child: Padding(
          padding: responsive.paddingAll(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTransactionIcon(),
              ResponsiveSpace(width: responsive.w(12)),
              Expanded(child: _buildTransactionDetails()),
              ResponsiveSpace(width: responsive.w(12)),
              // Amount with sign
          _buildTransactionBalance( sign),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionIcon() {
    return Container(
      padding: responsive.paddingAll(6),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(responsive.w(6)),
      ),
      child: Icon(
        transaction.type == TransactionType.debit
            ? Icons.arrow_upward
            : Icons.arrow_downward,
        color:
            transaction.type == TransactionType.debit
                ? Colors.green.shade600
                : Colors.red.shade600,
        size: responsive.w(24),
      ),
    );
  }

  Widget _buildTransactionDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAutoSizeText(
          text: transaction.id,
          fontWeight: FontWeight.bold,
          colorText: theme.colorScheme.onSurface,
          style: theme.textTheme.bodyMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          fontSize: 12,
          
        ),
        ResponsiveSpace(height: responsive.h(4)),
        CustomAutoSizeText(
          text:
              '${transaction.description} ',
          colorText: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          style: theme.textTheme.labelSmall,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          fontSize: 12,
        ),
      ],
    );
  }

  Widget _buildTransactionBalance( String sign) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomAutoSizeText(
          text: '$sign ${transaction.amount.toStringAsFixed(2)}',
          fontWeight: FontWeight.bold,
          colorText: transaction.type == TransactionType.debit
              ? Colors.green.shade600
              : Colors.red.shade600,
          style: theme.textTheme.bodyMedium,
        ),
        ResponsiveSpace(height: responsive.h(4)),
        CustomAutoSizeText(
          text: '${transaction.date.year}/${transaction.date.month}/${transaction.date.day}',
          colorText: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          fontSize: 12,
        ),
      ],
    );
}

}
