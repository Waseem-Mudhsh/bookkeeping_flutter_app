import 'package:bookkeeping_flutter_app/core/app_scaffold/adaptive_scaffold.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_tab_bar_layout.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_alert_dialog_enhanced.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_icon_button.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/widgets/action_buttons_row.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/widgets/financial_bottom_navbar.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/widgets/mester_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../core/utils/route_names.dart';
import '../../../../core/widgets/custom_auto_size_text.dart';
import '../../../../core/widgets/responsive_space.dart';
import '../../../Transactions/presentation/widgets/transaction_list.dart';
import '../../domain/entities/account.dart';



class AccountDetailsScreen extends ConsumerWidget {
  final Account account;

  const AccountDetailsScreen({super.key, required this.account});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Tab> tabs = [
      Tab(text: 'يمني'),
      Tab(text: 'سعودي'),
      Tab(text: 'دولار'),
      
      
     
    ];
    final theme = ref.theme;
    
   
    

    return AdaptiveScaffold(
     
      body: BuildTabBarLayout(
        hasDrawer: false,
        leadingWidget:  CustomIconButton(hugeIcon: HugeIcons.strokeRoundedArrowRight01,
        onPressed: () => Navigator.pop(context), ),
       
             titleWidget: _buildHeader(context,ref),
            //  backgroundWidget: MesterCard( id: account.name,
            //  balance: '500000',
            //  color: theme.colorScheme.secondaryContainer,

            //  ),
             backgroundWidget: _buildInfoAccount(context, account, ref),
            
            
         tabs: tabs,
          initialTabIndex: 0,
         
           
         
            expandedHeight:300,
          
            
            
        tabViews: [
          _buildTransactionListByCurrency(),
          _buildTransactionListByCurrency(),
          _buildTransactionListByCurrency(),
         
        

          
        ],
             ),
      // // FloatingActionButton.extended for adding new transactions
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: theme.colorScheme.secondaryContainer,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionSubRoutes.create.screenAdd(account.id, ),
            ),
          );
        },
        label: CustomAutoSizeText(
          text: 'إضافة عملية جديدة',
          style: theme.textTheme.bodyMedium,
          fontSize: 12,
          colorText: theme.colorScheme.onSecondaryContainer,
          
        ),
        icon: CustomHugeIcon(
          icon: HugeIcons.strokeRoundedMoneyAdd01,
          size:20,
          color: theme.colorScheme.onSecondaryContainer,),
      ),
      // bottomNavigationBar: AccountBalanceInfo(account: account!),
      widgetBottomNavigationBar: FinancialBottomNavBar( creditBalance: account.creditor , debitBalance: account.debtor,),
     
    );
  }
  Widget _buildHeader( BuildContext context, WidgetRef ref){
    final theme = ref.theme;
    
    
    return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
    
            CustomAutoSizeText(
              text: account.name ,
              style: theme.textTheme.bodyMedium,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              colorText: theme.colorScheme.primary,
            ),
             ResponsiveSpace(height: 4),
             CustomAutoSizeText(
              text: '+967 ${account.phoneNumber}',
              style: theme.textTheme.bodyMedium,
              
              fontSize: 10,
              colorText: theme.colorScheme.primary,
            ),
          ],
        );
  }
  Widget _buildInfoAccount( BuildContext context, Account account, WidgetRef ref)
   {
    final theme = ref.theme;
    final responsive = ref.responsive;
    final double topPadding = MediaQuery.of(context).padding.top;
    return Container(
      
      padding: responsive.paddingAll(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withAlpha(70),
          ],
        ),
      ),
      child: Padding(
        padding:  EdgeInsets.only(top: topPadding + kToolbarHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoRow(
              icon: HugeIcons.strokeRoundedUser,
              label: 'الحساب:',
              value: account.name,
            ),
            ResponsiveSpace(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: _InfoRow(
                    icon: HugeIcons.strokeRoundedCall02,
                    label: 'الهاتف:',
                    value: account.phoneNumber ?? 'غير متوفر',
                  ),
                ),
                const ResponsiveSpace(width: 16.0),
                Expanded(
                  child: _InfoRow(
                    icon: HugeIcons.strokeRoundedLayer,
                    label: 'التصنيف:',
                    value: account.category,
                  ),
                ),
              ],
            ),
            const ResponsiveSpace(height: 8.0),
              
           Row(
            children: [
              Expanded(
                child: _InfoRow(
                icon: HugeIcons.strokeRoundedCoinsDollar,
                label: 'سقف الحساب:',
                value: account.totalAccountBalance.toStringAsFixed(0),
                            ),
              ),
            const ResponsiveSpace(width: 16.0),
            Expanded(
              child: _InfoRow(
                icon: HugeIcons.strokeRoundedLimitation,
                label: 'الحالة:',
                value: 'ضمن حدود السقف', // This seems to be static
                valueColor: Colors.green.shade200,
              ),
            ),

            ],
           ),
            
            const ResponsiveSpace(height: 16.0),
            _accountActionsRow(context, ref)
          ],
        ),
      ),
    );
  }
 
  Widget _buildTransactionListByCurrency( ) {
    
    
    return TransactionList(account: account);
  }
  Widget _accountActionsRow( BuildContext context,WidgetRef ref){ {
    final theme = ref.theme;

    // Data-driven list for action buttons
    final List<Map<String, dynamic>> actions = [
      {
        'icon': HugeIcons.strokeRoundedCall02,
        'onPressed': () => _showCallDialog(context, ref),
      },
      {
        'icon': HugeIcons.strokeRoundedMessage01,
        'onPressed': () => _showMessageDialog(context, ref),
      },
      {
        'icon': HugeIcons.strokeRoundedLimitOrder,
        'onPressed': () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RouteNames.accountCeilingScreen.screen,
              ),
            ),
      },
      {
        'icon': HugeIcons.strokeRoundedPdf01,
        'onPressed': () => _showReportDialog(context),
      },
    ];

    return ActionButtonsRow(
      actionButtons: actions.map((action) => ActionButton(
        icon: action['icon'],
        onPressed: action['onPressed'],
        isCompact: true,
        iconColor: theme.colorScheme.primary,
      )).toList(),
    );
  }
  }
  
  // Dialog for adding a new transaction
  

  // Dialog for making a call
  void _showCallDialog(BuildContext context,WidgetRef ref) {
    
    

    final theme = ref.theme;
    

    showCustomDialog(
      context: context,
      barrierDismissible: true,
      title: 'إجراء مكالمة',
      hugeIconTitle: HugeIcons.strokeRoundedCall02,
      content: CustomAutoSizeText(
        text: 'هل تريد الاتصال بالرقم ${account.phoneNumber}؟',
        fontSize: 12,
        fontWeight: FontWeight.w700,
        maxLines: 2,
        colorText: theme.colorScheme.onSurface,
        style: theme.textTheme.bodyMedium,
      ),
      actions: [
        CustomButton(
          onPressed: () {
            // Implement call functionality here
            Navigator.pop(context);
          },
          backgroundColor: theme.colorScheme.primary,
          width: 80,
          height: 20,
          text: 'اتصال',
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: CustomAutoSizeText(
            text: 'إلغاء',
            colorText: theme.colorScheme.onSurface,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ]
     
      
    );


  }

  // Dialog for sending a message
  void _showMessageDialog(BuildContext context,WidgetRef ref) {
  
    final theme = ref.theme;
    

    showCustomDialog(
      context: context,
      barrierDismissible: true,
      title: 'إرسال رسالة',
      hugeIconTitle: HugeIcons.strokeRoundedMessage01,
      content: CustomAutoSizeText(
        text: 'هل تريد إرسال رسالة إلى الرقم ${account.phoneNumber}؟',
        fontSize: 12,
        fontWeight: FontWeight.w700,
        maxLines: 2,
        colorText: theme.colorScheme.onSurface,
        style: theme.textTheme.bodyMedium,
      ),
      actions: [
        CustomButton(
          onPressed: () {
            // Implement message sending functionality here
            Navigator.pop(context);
          },
          backgroundColor: theme.colorScheme.primary,
          width: 80,
          height: 20,
          text: 'إرسال',
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: CustomAutoSizeText(
            text: 'إلغاء',
            colorText: theme.colorScheme.onSurface,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ]
     
      
    );
    
  }

  

  // Dialog for generating report
  void _showReportDialog(BuildContext context) {
    final theme = Theme.of(context);

    showCustomDialog(

      context: context,
      barrierDismissible: true,
      title:'تقرير الحساب' ,
      hugeIconTitle: HugeIcons.strokeRoundedPdf01,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          CustomAutoSizeText(
            text: 'هل تريد إنشاء تقرير عن الحساب: ${account.name}',
            fontSize: 12,
            
            colorText: theme.colorScheme.onSurface,
            style: theme.textTheme.bodyMedium,
            fontWeight: FontWeight.w700,
          ),
          ResponsiveSpace(height: 8),
          CustomAutoSizeText(
            text: 'سيتم إنشاء تقرير شامل يحتوي على جميع العمليات والحسابات',
            fontSize: 12,
            
            colorText: theme.colorScheme.onSurface,
            style: theme.textTheme.bodyMedium,
            fontWeight: FontWeight.w500,
            maxLines: 2,
          ),
          
          
        ],
      ),
      actions: [
        CustomButton(
                onPressed: () {
                  // Implement report generation functionality here
                  Navigator.pop(context);
                },
                 backgroundColor: theme.colorScheme.primary,
                width: 80,
                height: 20,
                text: 'إنشاء تقرير',
                
              ),
              TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: CustomAutoSizeText(
              text: 'إلغاء',
              colorText: theme.colorScheme.onSurface,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              style: theme.textTheme.bodyMedium,
            ),
          ),

      ],
    );
  }
}

class _InfoRow extends ConsumerWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomHugeIcon(
          icon: icon,
          size: 16.0,
          color: theme.colorScheme.onPrimary.withAlpha(80),
        ),
        const ResponsiveSpace(width: 8.0),
        CustomAutoSizeText(
          text: label,
          style: theme.textTheme.bodyMedium,
          colorText: theme.colorScheme.onPrimary.withAlpha(80),
          fontSize: 12.0,
        ),
        const ResponsiveSpace(width: 4.0),
        Expanded(
          child: CustomAutoSizeText(
            text: value,
            style: theme.textTheme.bodyMedium,
            fontWeight: FontWeight.bold,
            colorText: valueColor ?? theme.colorScheme.onPrimary,
            fontSize: 12.0,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}



// How to use it:
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => AccountDetailsScreen(
//       account: Account(
//         id: '1',
//         name: 'حساب بنك الأمل',
//         balance: 450.00,
//         currency: Currency(code: 'USD', name: 'دولار', symbol: '\$'),
//       ),
//     ),
//   ),
// );