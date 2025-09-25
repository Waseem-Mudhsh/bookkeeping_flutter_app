import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../core/utils/route_names.dart';
import '../../../../core/widgets/custom_auto_size_text.dart';
import '../../../../core/widgets/responsive_space.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_type.dart';
import '../Providers/transaction_provider.dart';

class CustomTransactionItem extends ConsumerWidget {
  final Transaction transaction;

  const CustomTransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final responsive = ref.responsive;

    String sign = transaction.type == TransactionType.credit ? '+' : '-';
    return Padding(
      padding: responsive.paddingOnly(bottom: responsive.h(4)),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.5),
          ),
          borderRadius: BorderRadius.circular(responsive.w(12)),
        ),
        onTap: () {
          _showTransactionOptions(context, ref);
        },
        leading: _buildTransactionIcon(),
        title: _buildTransactionDetails(ref),
        trailing: _buildTransactionBalance(sign, ref),
        contentPadding: responsive.paddingSym(h: 16, v: 8),
      ),
    );
  }

  // دالة رئيسية لعرض الـ BottomSheet
  Future<void> _showTransactionOptions(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final responsive = ref.responsive; // تأكد من الحصول على ResponsiveValues
    final theme = ref.theme; // تأكد من الحصول على Theme

    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(responsive.w(16)),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: responsive.paddingAll(16),
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // هذا هو الخيار الصحيح لتجنب مشاكل الحجم
            children: [
              _buildOption(
                theme: theme,
                context,
                icon: HugeIcons.strokeRoundedEdit01,
                iconColor: theme.colorScheme.primary,
                title: 'تعديل العملية',
                onTap: () {
                  Navigator.pop(context);
                  _onEditTransaction(context)();
                },
              ),
              _buildOption(
                theme: theme,
                context,
                icon: HugeIcons.strokeRoundedDelete01,
                iconColor: theme.colorScheme.error,
                title: 'حذف العملية',
                onTap: () {
                  // Navigator.pop(context);
                  _onDeleteTransaction(context, ref)();
                },
              ),
              _buildOption(
                theme: theme,
                context,
                icon: HugeIcons.strokeRoundedShare01,
                iconColor: theme.colorScheme.secondary,
                title: 'مشاركة العملية',
                onTap: () {
                  Navigator.pop(context);
                  // TODO: تنفيذ مشاركة العملية
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // دالة مساعدة لإنشاء ListTile
  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
    required ThemeData theme,
  }) {
    return ListTile(
      leading: CustomHugeIcon(icon: icon, color: iconColor),
      title: Text(title, style: theme.textTheme.bodyMedium),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  VoidCallback _onEditTransaction(BuildContext context) {
    return () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => TransactionSubRoutes.create.screenEdit(
                transaction.accountId,
                transaction,
              ),
        ),
      );
    };
  }

  VoidCallback _onDeleteTransaction(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    return () {
      showConfirmationDialog(
        responsive: ref.responsive,
        theme: theme,
        context: context,
        title: 'تاكيد الحذف',
        content: Text('هل أنت متأكد من حذف هذه العملية؟'),
        onConfirm: () {
          // استدعاء دالة حذف العملية من Provider أو ViewModel هنا
          ref
              .read(
                transactionViewModelProvider(transaction.accountId).notifier,
              )
              .deleteTransaction(transaction.id);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomAutoSizeText(
                fontFamily: 'Cairo',
                text: 'تم حذف الحساب بنجاح!',
                colorText: Colors.white,
                fontSize: 12,
              ),
              backgroundColor: Colors.green,
            ),
          );
          // Navigator.pop(context); // Close the bottom sheet
          // إذا أردت إغلاق الـ BottomSheet بعد الحذف:
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
        confirmButtonText: 'حذف',
        cancelButtonText: 'إلغاء',
        confirmButtonColor: theme.colorScheme.error,
      );
    };
  }

  Widget _buildTransactionIcon() {
    return CustomHugeIcon(
      icon:
          transaction.type == TransactionType.credit
              ? HugeIcons.strokeRoundedSquareArrowUpRight
              : HugeIcons.strokeRoundedSquareArrowDownRight,
      color:
          transaction.type == TransactionType.credit
              ? Colors.green.shade600
              : Colors.red.shade600,
      size: 24,
    );
  }


  Widget _buildTransactionDetails(WidgetRef ref) {
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

  Widget _buildTransactionBalance(String sign, WidgetRef ref) {
    final theme = ref.theme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomAutoSizeText(
          text: '$sign ${transaction.amount.toStringAsFixed(2)}',
          fontWeight: FontWeight.bold,
          colorText:
              transaction.type == TransactionType.credit
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
