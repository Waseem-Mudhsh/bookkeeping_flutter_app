//
// File: lib/presentation/account/widgets/transaction_list_tabbar.dart
//
import 'package:bookkeeping_flutter_app/features/Transactions/presentation/widgets/custom_transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';

import '../../../../core/utils/responsive_values.dart';
import '../../../../core/widgets/custom_auto_size_text.dart';
import '../../../../core/widgets/custom_empty_state.dart';
import '../../../../core/widgets/custom_icon_button.dart';
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
    final theme = ref.watch(themeDataProvider);
    final responsive = ref.watch(responsiveProvider);
    
    final asyncTransactionsByAccountId = ref.watch(transactionViewModelProvider(account.id));
     

    return _RecentTransactionsSection(asyncTransactions: asyncTransactionsByAccountId,
     theme: theme, responsive: responsive, onViewAll: () {}, 
     onTransactionTap: (Transaction transaction) {
        // Handle transaction tap
        debugPrint('Tapped on transaction: ${transaction.description}');
      },);
  }
}
class _RecentTransactionsSection extends StatelessWidget {
  final AsyncValue<List<Transaction>> asyncTransactions;
  final ThemeData theme;
  final ResponsiveValues responsive;
  final VoidCallback onViewAll;
  final ValueChanged<Transaction> onTransactionTap;

  const _RecentTransactionsSection({
    required this.asyncTransactions,
    required this.theme,
    required this.responsive,
    required this.onViewAll,
    required this.onTransactionTap,
  });

  @override
  Widget build(BuildContext context) {
   

    return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: responsive.h(4),
      children: [
        Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomAutoSizeText(
                  text: 'عدد العمليات: ${asyncTransactions.value?.length ?? 0}',
                  style: theme.textTheme.bodyMedium,
                  fontWeight: FontWeight.w500,
                  colorText: theme.colorScheme.secondary,
                  fontSize: 12,
                ),
                Spacer(),
                CustomIconButton(
                  icon: const Icon(Icons.sort_outlined),
                  iconSize: responsive.w(24),
                  iconColor: theme.colorScheme.secondary,
                  onPressed: () {
                    // Handle sort action
                    debugPrint('Sort transactions');
                  },
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
                      
                    ),
                  ),
                ...transactions.reversed.map((transaction) {
                  return CustomTransactionItem(
                    transaction: transaction,
                    
                    theme: theme,
                    responsive: responsive,
                  );
                })
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