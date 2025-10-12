import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/features/Transactions/presentation/widgets/custom_transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../core/widgets/custom_auto_size_text.dart';
import '../../../../core/widgets/custom_empty_state.dart';
import '../../../../core/widgets/custom_icon_button.dart';
import '../../../../core/widgets/responsive_space.dart';
import '../../../Accounts/domain/entities/account.dart';
import '../../domain/entities/transaction.dart';
import '../Providers/transaction_provider.dart';
// Widget for a single transaction item

// This widget is responsible for the tab bar and the list of transactions.
class TransactionList extends ConsumerWidget {
  final Account account;

  const TransactionList({super.key, required this.account});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTransactionsByAccountId = ref.watch(
      transactionViewModelProvider(account.id),
    );

    return _RecentTransactionsSection(
      asyncTransactions: asyncTransactionsByAccountId,
    );
  }
}

class _RecentTransactionsSection extends ConsumerWidget {
  final AsyncValue<List<Transaction>> asyncTransactions;

  const _RecentTransactionsSection({required this.asyncTransactions});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final responsive = ref.responsive;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: responsive.h(8),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomAutoSizeText(
              text: 'عدد العمليات: ${asyncTransactions.value?.length ?? 0}',
              style: theme.textTheme.bodyMedium,
              fontWeight: FontWeight.w600,
              colorText: theme.colorScheme.primary,
              fontSize: 10,
            ),
            Spacer(),
            CustomIconButton(
              hugeIcon: HugeIcon(
                icon: HugeIcons.strokeRoundedSearch01,
                color: theme.colorScheme.primary,
                size: responsive.h(20),
              ),

              onPressed: () {},
            ),
            ResponsiveSpace(width: 8),
            CustomIconButton(
              hugeIcon: HugeIcon(
                icon: HugeIcons.strokeRoundedSorting01,
                color: theme.colorScheme.primary,
                size: responsive.h(20),
              ),

              onPressed: () {},
            ),
          ],
        ),

        asyncTransactions.when(
          data: (transactions) {
            return Column(
              spacing: responsive.h(4),
              children: [
                if (transactions.isEmpty)
                  Center(
                    child: CustomEmptyState(
                      message: 'لا توجد عمليات حديثة.',
                      subMessage: 'يمكنك إضافة عمليات جدد من خلال زر الإضافة ',
                      icon: HugeIcons.strokeRoundedMoneyAdd01,
                    ),
                  ),
                ...transactions.reversed.map((transaction) {
                  return CustomTransactionItem(transaction: transaction);
                }),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
        ),
      ],
    );
  }
}
