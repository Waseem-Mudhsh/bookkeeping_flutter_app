import 'package:bookkeeping_flutter_app/core/widgets/custom_horizontal_list_view.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/domain/entities/account.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/providers/account_provider.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/widgets/custom_account_card.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/widgets/custom_transaction_item.dart';
import 'package:bookkeeping_flutter_app/features/Customers/presentation/widgets/customer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookkeeping_flutter_app/core/utils/responsive_values.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart'; // Assume this widget exists

// Providers

import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';
import '../../../../core/widgets/custom_empty_state.dart';
import '../../../../core/widgets/custom_icon_button.dart';
import '../../../Currencies/presentation/widgets/custom_show_balince.dart';
import '../../../Customers/presentation/providers/customer_provider.dart';
import '../../../Customers/presentation/screens/customer_actions.dart';
import '../../../Transactions/domain/entities/transaction.dart';

// import 'package:bookkeeping_flutter_app/features/home/data/providers/currency_provider.dart'; // Assume this provider exists

// Domain Entities (Simplified for demonstration)
// You should have these in your 'domain/entities' folder




// class Transaction {
//   final String id;
//   final String description;
//   final double amount;
//   final DateTime date;
//   final TransactionType type; // Income, Expense, Transfer
//   final String accountName; // Name of the account involved
//   final IconData categoryIcon; // Icon for the category (e.g., food, transport)

//   Transaction({
//     required this.id,
//     required this.description,
//     required this.amount,
//     required this.date,
//     required this.type,
//     required this.accountName,
//     required this.categoryIcon,
//   });
// }

// enum TransactionType { income, expense, transfer }


// class AppAlert {
//   final String id;
//   final String message;
//   final AlertType type;
//   final DateTime? date;
//   final VoidCallback? onPressed; // Action to take when alert is tapped

//   AppAlert({
//     required this.id,
//     required this.message,
//     required this.type,
//     this.date,
//     this.onPressed,
//   });
// }

enum AlertType { warning, info, critical }





// final List<Transaction> mockTransactions = [
//   Transaction(id: 't1', description: 'راتب شهر يونيو', amount: 300000.00, date: DateTime.now().subtract(const Duration(days: 1)), type: TransactionType.income, accountName: 'حساب التوفير الرئيسي', categoryIcon: Icons.attach_money),
//   Transaction(id: 't2', description: 'إيجار الشقة', amount: 500.00, date: DateTime.now().subtract(const Duration(days: 2)), type: TransactionType.expense, accountName: 'بطاقة ائتمان فيزا', categoryIcon: Icons.house),
//   Transaction(id: 't3', description: 'مشتريات سوبر ماركت', amount: 15000.00, date: DateTime.now().subtract(const Duration(days: 3)), type: TransactionType.expense, accountName: 'محفظة الكاش', categoryIcon: Icons.shopping_cart),
//   Transaction(id: 't4', description: 'تحويل إلى حساب الأخت', amount: 100.00, date: DateTime.now().subtract(const Duration(days: 4)), type: TransactionType.transfer, accountName: 'حساب التوفير الرئيسي', categoryIcon: Icons.sync_alt),
//   Transaction(id: 't5', description: 'فاتورة الكهرباء', amount: 200.00, date: DateTime.now().subtract(const Duration(days: 5)), type: TransactionType.expense, accountName: 'حساب التوفير الرئيسي', categoryIcon: Icons.lightbulb),
//   Transaction(id: 't6', description: 'مصاريف السيارة', amount: 300.00, date: DateTime.now().subtract(const Duration(days: 6)), type: TransactionType.expense, accountName: 'بطاقة ائتمان فيزا', categoryIcon: Icons.directions_car),
// ];

// final List<AppAlert> mockAlerts = [
//   AppAlert(id: 'al1', message: 'الرصيد في محفظة الكاش منخفض!', type: AlertType.warning, onPressed: () => debugPrint('Top up cash')),
//   AppAlert(id: 'al2', message: 'فاتورة الكهرباء مستحقة غدًا.', type: AlertType.info, onPressed: () => debugPrint('Pay electricity bill')),
// ];

// Main Screen Widget
class AccountsScreen extends ConsumerWidget {
  final ThemeData theme;
  final ResponsiveValues responsive;
  
  final AsyncValue<List<Transaction>> asyncTransactions;


  const AccountsScreen({
    super.key,
    required this.theme,
    required this.responsive,
    
    required this.asyncTransactions,
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

    return  Column(
     mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- 1. Total Balance Card ---
        CustomShowBalince(),
        ResponsiveSpace(height: responsive.h(8)),
        
        CustomHorizontalListView(
          responsive: responsive,
          theme: theme,
          nameButtons: categorices,
           contentWidgets: [
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
           ]
           ),
        
       
       
        ResponsiveSpace(height: responsive.h(16)),
        
        // --- 4. Recent Transactions Overview ---
        _RecentTransactionsSection(
          asyncTransactions: asyncTransactions , // Pass actual transactions
          theme: theme,
          responsive: responsive,
          onViewAll: () {
            // TODO: Navigate to All Transactions Screen
            debugPrint('View All Transactions pressed');
          },
          onTransactionTap: (transaction) {
            // TODO: Navigate to Transaction Details
            debugPrint('Transaction tapped: ${transaction.description}');
          },
        ),
        ResponsiveSpace(height: responsive.h(24)),
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
  final VoidCallback onAddAccount; // For an "add account" button if needed inside the section

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
        data: (accounts) =>
          accounts.isEmpty ? _buildEmptyState() : _buildAccountsList(accounts),
        );

  }
  Widget _buildLoading()  {
       
        return const Center(child: CircularProgressIndicator());
      }

  Widget _buildError(Object error) => Center(child: Text('Error: $error'));

  Widget _buildEmptyState() {
    return Consumer(
      builder: (context, ref, _) {
        final theme = ref.watch(themeDataProvider);
        return Center(
          child: CustomEmptyState(
            message: 'لا يوجد حسابات',
            subMessage: 'يمكنك إضافة حسابات جديدة من خلال زر الإضافة',
            theme: theme,
          ),
        );
      },
    );
  }

  Widget _buildAccountsList(List<dynamic> accounts) {

    return Consumer(
      builder: (context, ref, child) {
       
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
                  text: 'عدد الحسابات: ${accounts.length}',
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
                  onPressed: onAddAccount,
                )
             
              ],
            ),
            
            ...accounts.map(
              (account) => CustomAccountCard(
                account: account,
                onTap: onAccountTap,
                responsive: responsive,
                theme: theme,
              ),
            ),
          ],
        );
      } ,
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
          spacing:responsive.h(4),
        children: [
         
          
          if (transactions.isEmpty)
            Center(
                  child: CustomEmptyState(
                     message: 'لا توجد عمليات حديثة.',
                    subMessage: 'يمكنك إضافة عمليات جدد من خلال زر الإضافة ',
                    theme: theme,
                  ),
                ),
            ...transactions.map((transaction) => CustomTransactionItem(
              transaction:transaction,
              responsive: responsive,
              onTap: onTransactionTap,
              theme: theme,
              )),
          
            
        ],
      );},
      loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text(error.toString())));
  }

 

}
