


import 'package:bookkeeping_flutter_app/core/widgets/custom_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/responsive_values.dart';
import '../../../../core/utils/route_names.dart';
import '../../../../core/widgets/custom_auto_size_text.dart';
import '../../../../core/widgets/responsive_space.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_type.dart';
import '../Providers/transaction_provider.dart';

class CustomTransactionItem extends ConsumerWidget {
  final Transaction transaction;
  
  final ResponsiveValues responsive;
  final ThemeData theme;
  const CustomTransactionItem({
    super.key,
    required this.transaction,
   
    required this.responsive,
    required this.theme,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    String sign = transaction.type == TransactionType.debit ? '+' : '-';
    return Card(
      elevation: 2,
      margin: responsive.paddingOnly(bottom: responsive.h(8)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(responsive.w(10)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(responsive.w(10)),
        onTap: (){
          _showTransactionOptions(context, ref);
        },
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
  Future<void> _showTransactionOptions(BuildContext context,WidgetRef ref) async {
    return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(responsive.w(16))),
    ),
    builder: (context) {
      return Padding(
        padding: responsive.paddingAll(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit, color: theme.colorScheme.primary),
              title: Text('تعديل العملية', style: theme.textTheme.bodyMedium),
              onTap: () {
                Navigator.pop(context);
                _onEditTransaction(context)();
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: theme.colorScheme.error),
              title: Text('حذف العملية', style: theme.textTheme.bodyMedium),
              onTap: () {
                _onDeleteTransaction(context, ref)(); // استدعاء دالة حذف العملية من Provider انا
              },
            ),
            ListTile(
              leading: Icon(Icons.share, color: theme.colorScheme.secondary),
              title: Text('مشاركة العملية', style: theme.textTheme.bodyMedium),
              onTap: () {
                Navigator.pop(context);
                // TODO: تنفيذ مشاركة العملية (مثلاً عبر Share package)
              },
            ),
          ],
        ),
      );
    },
  );
  }
  VoidCallback _onEditTransaction(BuildContext context) {
    return () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TransactionSubRoutes.create.screenEdit(
            transaction.accountId,
            transaction,
          ),
        ),
      );
    };
  }
  VoidCallback _onDeleteTransaction(BuildContext context, WidgetRef ref) {
    return () {
     showConfirmationDialog(
      context: context,
      title: 'تاكيد الحذف',
      content: Text('هل أنت متأكد من حذف هذه العملية؟'),
      onConfirm: () {
        // استدعاء دالة حذف العملية من Provider أو ViewModel هنا
       ref.read(transactionViewModelProvider(transaction.accountId).notifier).deleteTransaction(transaction.id);
        Navigator.pop(context); // إغلاق النافذة المنبثقة
       
      },
       );
    };
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
