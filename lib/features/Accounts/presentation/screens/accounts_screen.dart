import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_horizontal_list_view.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/domain/entities/account.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/providers/account_provider.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/screens/account_details_screen.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/widgets/custom_account_card.dart';
import 'package:bookkeeping_flutter_app/features/Transactions/presentation/widgets/custom_transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookkeeping_flutter_app/core/utils/responsive_values.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import '../../../../core/widgets/custom_empty_state.dart';
import '../../../../core/widgets/custom_icon_button.dart';
import '../../../../core/widgets/responsive_space.dart';
import '../../../Transactions/domain/entities/transaction.dart';





// Main Screen Widget
class AccountsScreen extends ConsumerWidget {

  const AccountsScreen({
    super.key,
   
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final List<String> categorices = [
      'العملاء',
      'الموردين',
      'الرواتب',
      'الضرائب',
      'المصروفات',
    ];

    final theme = ref.theme;
    final responsive = ref.responsive;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      

        CustomHorizontalListView(
          responsive: responsive,
          theme: theme,
          nameButtons: categorices,
          contentWidgets: [
            
            _AccountsListSection(
              theme: theme,
              responsive: responsive,
              onAccountTap: (account) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => AccountDetailsScreen(account: account),
                  ),
                );
                // TODO: Navigate to Account Details
                debugPrint('Account tapped: ${account.name}');
              },
              onAddAccount: () {
                debugPrint('Add account from list pressed');
              },
            ),
            _AccountsListSection(
              theme: theme,
              responsive: responsive,
              onAccountTap: (account) {
                // TODO: Navigate to Account Details
                debugPrint('Account tapped: ${account.name}');
              },
              onAddAccount: () {
                debugPrint('Add account from list pressed');
              },
            ),
            _AccountsListSection(
              theme: theme,
              responsive: responsive,
              onAccountTap: (account) {
                // TODO: Navigate to Account Details
                debugPrint('Account tapped: ${account.name}');
              },
              onAddAccount: () {
                debugPrint('Add account from list pressed');
              },
            ),
            _AccountsListSection(
              theme: theme,
              responsive: responsive,
              onAccountTap: (account) {
                // TODO: Navigate to Account Details
                debugPrint('Account tapped: ${account.name}');
              },
              onAddAccount: () {
                debugPrint('Add account from list pressed');
              },
            ),
            _AccountsListSection(
              theme: theme,
              responsive: responsive,
              onAccountTap: (account) {
                // TODO: Navigate to Account Details
                debugPrint('Account tapped: ${account.name}');
              },
              onAddAccount: () {
                debugPrint('Add account from list pressed');
              },
            ),
          ],
        ),

      
      ],
    );
  }

  // Helper method to build the Total Balance Card
}

/// --- Separate Widgets for Sections ---

// 2. Alerts and Notifications Section

// 3. Accounts List Section
class _AccountsListSection extends ConsumerWidget {
  final ThemeData theme;
  final ResponsiveValues responsive;
  final ValueChanged<Account> onAccountTap;
  final VoidCallback
  onAddAccount; // For an "add account" button if needed inside the section

  const _AccountsListSection({
    required this.theme,
    required this.responsive,
    required this.onAccountTap,
    required this.onAddAccount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAccounts = ref.watch(accountViewModelProvider);
    return asyncAccounts.when(
      loading: () => _buildLoading(),
      error: (error, _) => _buildError(error),
      data:
          (accounts) =>
              accounts.isEmpty
                  ? _buildEmptyState()
                  : _buildAccountsList(accounts),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError(Object error) => Center(child: Text('Error: $error'));

  Widget _buildEmptyState() {
    return Consumer(
      builder: (context, ref, _) {
        
        
        return Padding(
          padding: responsive.paddingOnly(top:16),
          child: Center(
            child: CustomEmptyState(
              message: 'لا يوجد حسابات',
              subMessage: 'يمكنك إضافة حسابات جديدة من خلال زر الإضافة',
              
            ),
          ),
        );
      },
    );
  }

  Widget _buildAccountsList(List<dynamic> accounts) {
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
              text: 'عدد الحسابات: ${accounts.length}',
              style: theme.textTheme.bodyMedium,
              fontWeight: FontWeight.w600,
              colorText: theme.colorScheme.tertiary,
              fontSize: 12,
            ),
            Spacer(),
            CustomIconButton(
              icon: const Icon(Icons.search_outlined),
              iconSize: 20,
              iconColor: theme.colorScheme.tertiary,
              onPressed: onAddAccount,
              backgroundColor: theme.colorScheme.tertiary.withValues(alpha: 0.05),
            ),
            ResponsiveSpace(width: 8),
            CustomIconButton(
              icon: const Icon(Icons.sort_outlined),
              iconSize: 20,
              iconColor: theme.colorScheme.tertiary,
              onPressed: onAddAccount,
              backgroundColor: theme.colorScheme.tertiary.withValues(alpha: 0.05),
            ),
          ],
        ),
        
    
        ...accounts.map(
          (account) => CustomAccountCard(
            account: account,
            onTap: onAccountTap,
            
            // theme: theme,
          ),
        ),
      ],
    );
  }
 
}

// 4. Recent Transactions Overview Section
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
    // Determine how many transactions to show
    // final int itemsToShow = transactions.length > 5 ? 5 : transactions.length;
    // final bool hasMore = transactions.length > 5;
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         CustomAutoSizeText(
    //           text: 'آخر المعاملات',
    //           style: theme.textTheme.titleLarge?.copyWith(
    //             fontWeight: FontWeight.bold,
    //             color: theme.colorScheme.onSurface,
    //           ),
    //         ),
    //         if (hasMore)
    //           TextButton(
    //             onPressed: onViewAll,
    //             child: CustomAutoSizeText(
    //               text: 'عرض الكل (${transactions.length})',
    //               style: theme.textTheme.labelLarge?.copyWith(
    //                 color: theme.colorScheme.primary,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //           ),
    //       ],
    //     ),
    //     ResponsiveSpace(height: responsive.h(12)),
    //     if (transactions.isEmpty)
    //       Padding(
    //         padding: responsive.paddingAll(16),
    //         child: Center(
    //           child: CustomAutoSizeText(
    //             text: 'لا توجد معاملات حديثة.',
    //             style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
    //             textAlign: TextAlign.center,
    //           ),
    //         ),
    //       )
    //     else
    //       ListView.builder(
    //         shrinkWrap: true,
    //         physics: const NeverScrollableScrollPhysics(),
    //         itemCount: itemsToShow, // Show max 5 recent transactions
    //         itemBuilder: (context, index) {
    //           final transaction = transactions[index];
    //           return CustomTransactionItem(
    //             transaction:transaction,
    //             responsive: responsive,
    //             onTap: onTransactionTap,
    //             theme: theme,
    //             );
    //         },
    //       ),
    //   ],
    // );

    return asyncTransactions.when(
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
            ...transactions.map(
              (transaction) => CustomTransactionItem(
                transaction: transaction,
                responsive: responsive,
                
                theme: theme,
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
    );
  }
}
