import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/features/Transactions/domain/entities/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/custom_auto_size_text.dart';
import '../../../Accounts/presentation/screens/clientsScreen/merchant_ledger_screen.dart';

class CustomTransactionItemOfClient extends ConsumerWidget {
  final TransactionModel transaction;
  final VoidCallback onTap;
  const CustomTransactionItemOfClient({super.key, 
    required this.transaction,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final responsive = ref.responsive;
    
// Green for 'له' (Debit), Red for 'عليه' (Credit)
    String sign = transaction.isDebit == TransactionType.credit ? '+' : '-';
    Color colorBorder = transaction.isDebit == TransactionType.credit ? Colors.green :theme.colorScheme.error;

    return Padding(
      padding:responsive.paddingOnly(bottom: responsive.h(4)),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: colorBorder.withValues(alpha: 0.3),width: 0.5
          ),
          borderRadius: BorderRadius.circular(responsive.w(12)),
        ),
       onTap: onTap,
        contentPadding: responsive.paddingSym(h: 16, v: 8),
        titleAlignment: ListTileTitleAlignment.center,
      
        
        // TITLE: Transaction Details (البيان)
        title: Padding(
          padding: responsive.paddingOnly(bottom: 4),
          child: _buildTitleTransaction(ref)
        ),
        
       
        subtitle: _buildSubTitleTransaction(ref),
        
        // TRAILING: Date and Time
        trailing: _buildTrailingTransaction(ref, sign),
      ),
    );
  }
  

  Widget _buildTitleTransaction(WidgetRef ref) {
    final theme = ref.theme;
    return CustomAutoSizeText(
      text: transaction.description,
      fontWeight: FontWeight.w600,
      colorText: theme.colorScheme.onSurface,
      style: theme.textTheme.bodyMedium,
      maxLines: 10,
      overflow: TextOverflow.ellipsis,
      fontSize: 12,
    );
  }
  Widget _buildSubTitleTransaction(WidgetRef ref) {
    final theme = ref.theme;
    return CustomAutoSizeText(
      text:'المستفيد: ${transaction.buyer}',
      fontWeight: FontWeight.w400,
      colorText: theme.colorScheme.onSurface,
      style: theme.textTheme.bodySmall,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      fontSize: 10,
    );
  }
  Widget _buildTrailingTransaction(WidgetRef ref, String sign) {
    final theme = ref.theme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomAutoSizeText(
          text: '$sign ${transaction.amount.toStringAsFixed(2)}',
          fontWeight: FontWeight.bold,
          colorText:
              transaction.isDebit == TransactionType.credit
                  ? Colors.green.shade600
                  : Colors.red.shade600,
          style: theme.textTheme.bodyMedium,
        ),
        ResponsiveSpace(height: 4),
        CustomAutoSizeText(
          text:
              '${transaction.date.year}/${transaction.date.month}/${transaction.date.day}',
          colorText: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          fontSize: 10,
        ),
      ],
    );
  }
}