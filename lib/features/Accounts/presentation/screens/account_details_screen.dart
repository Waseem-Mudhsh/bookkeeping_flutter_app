import 'package:bookkeeping_flutter_app/core/base_layout/build_tab_bar_layout.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_alert_dialog_enhanced.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_tab_view_container.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/widgets/action_buttons_row.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/widgets/financial_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../core/base_layout/base_layout_screen.dart';
import '../../../../core/utils/route_names.dart';
import '../../../../core/widgets/custom_auto_size_text.dart';
import '../../../../core/widgets/responsive_space.dart';
import '../../../Transactions/presentation/widgets/transaction_list.dart';
import '../../domain/entities/account.dart';



class AccountDetailsScreen extends ConsumerWidget {
  final Account? account;

  const AccountDetailsScreen({super.key, this.account});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Tab> tabs = [
      Tab(text: 'يمني'),
      Tab(text: 'سعودي'),
      Tab(text: 'دولار'),
      
     
    ];
    final theme = ref.theme;
    final responsive = ref.responsive;
   
    

    return BaseLayoutScreen(
      // body: BuildNonTabbarLayout(
       
      //   titleWidget: _buildHeader(theme),
      //    toolbarHeight: responsive.h(60),
        
      //  slivers: [
      //     SliverToBoxAdapter(
      //       child: ResponsiveSpace( height: 16,),
      //     ),
      //     SliverToBoxAdapter(
      //       child: CustomSegmentedButton(
      //         nameButtons: ['يمني','سعودي', 'دولار'],
      //         contentButtons:[
      //           _buildTransactionListByCurrency(ref),
      //           _buildTransactionListByCurrency(ref),
      //           _buildTransactionListByCurrency(ref),
                

              
      //         ] ,
      //          ),
      //     ),
         
      //  ],
        
       
      //   hasLeading: false,
        
      // ),
      body: BuildTabBarLayout(
             titleWidget: _buildHeader(theme),
         tabs: tabs,
          initialTabIndex: 0,
           hasLeading: false,
          //  isScrollableTabs: true,
            toolbarHeight: 90,
        tabViews: [
          CustomTabViewContainer(responsive: responsive,
          child: _buildTransactionListByCurrency(context,ref)),
          CustomTabViewContainer(responsive: responsive,
          child: _buildTransactionListByCurrency(context,ref)),
          CustomTabViewContainer(responsive: responsive,
          child: _buildTransactionListByCurrency(context,ref)),
        

          
        ],
             ),
      // // FloatingActionButton.extended for adding new transactions
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: theme.colorScheme.secondaryContainer,
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => TransactionSubRoutes.create.screenAdd(account!.id, ),
      //       ),
      //     );
      //   },
      //   label: CustomAutoSizeText(
      //     text: 'إضافة عملية جديدة',
      //     style: theme.textTheme.bodyMedium,
      //     fontSize: 12,
      //     colorText: theme.colorScheme.onSecondaryContainer,
          
      //   ),
      //   icon: CustomHugeIcon(
      //     icon: HugeIcons.strokeRoundedMoneyAdd01,
      //     size:20,
      //     color: theme.colorScheme.onSecondaryContainer,),
      // ),
      // bottomNavigationBar: AccountBalanceInfo(account: account!),
      bottomNavigationBar: FinancialBottomNavBar( creditBalance: account?.creditor ?? 0, debitBalance: account?.debtor ?? 0,),
     
    );
  }
  Widget _buildHeader( ThemeData theme){
    return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CustomAutoSizeText(
              text: account?.name ?? 'تفاصيل الحساب',
              style: theme.textTheme.bodyMedium,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              colorText: theme.colorScheme.primary,
            ),
             ResponsiveSpace(height: 4),
             CustomAutoSizeText(
              text: 'هاتف الحساب: ${account?.phoneNumber}',
              style: theme.textTheme.bodyMedium,
              
              fontSize: 10,
              colorText: theme.colorScheme.primary,
            ),
          ],
        );
  }
 
  Widget _buildTransactionListByCurrency( BuildContext context,WidgetRef ref) {
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       
        
        ResponsiveSpace(height: 8),
        ResponsiveSpace(
          height: 60,
          child: _accountActionsRow(context,ref)),
        ResponsiveSpace(height: 16),
        TransactionList(account: account!),
        ResponsiveSpace(height: 8),
    
    
      ],
    );  
  }
  Widget _accountActionsRow( BuildContext context,WidgetRef ref){ {
    final theme = ref.theme;
    return ActionButtonsRow(
      actionButtons: [
        ActionButton(label: 'إضافة عملية', icon: HugeIcons.strokeRoundedMoneyAdd01,
         onPressed: (){
          // Show add transaction dialog
          Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionSubRoutes.create.screenAdd(account!.id, ),
                    ),
                  );
         },isCompact: true,backgroundColor:theme.colorScheme.primary,iconColor: theme.colorScheme.onPrimary,),
        ActionButton(label: 'اتصال', icon: HugeIcons.strokeRoundedCall02, onPressed: (){
          // Show call dialog
          _showCallDialog(context,ref);
        },isCompact: true,),
        ActionButton(label: 'رسالة', icon: HugeIcons.strokeRoundedMessage01, onPressed: (){
          // Show message dialog
          _showMessageDialog(context,ref);
        },isCompact: true,),
        ActionButton(label: 'سقف الحساب', icon: HugeIcons.strokeRoundedLimitOrder, onPressed: (){
          // Show account limit dialog
          // _showAccountLimitDialog(context);
          Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RouteNames.accountCeilingScreen.screen,
                    ),
                  );
        },isCompact: true,),
        ActionButton(label: 'تقرير', icon: HugeIcons.strokeRoundedPdf01, onPressed: (){
          // Show report dialog
          _showReportDialog(context);
        },isCompact: true,),
      ],
    );
  }
  }
  
  // Dialog for adding a new transaction
  

  // Dialog for making a call
  void _showCallDialog(BuildContext context,WidgetRef ref) {
    
    debugPrint(account?.phoneNumber);

      showCustomAlert(context: context, ref: ref,
       title: 'اتصال',
        message: 'هل تريد الاتصال بالرقم ${account?.phoneNumber}؟',
        confirmText: 'اتصال',
        cancelText: 'اغلاق',
        onConfirm: () {
          // Implement call functionality here
          Navigator.pop(context);
        },
        hugeIcon: HugeIcons.strokeRoundedCall02,
         
        );


  }

  // Dialog for sending a message
  void _showMessageDialog(BuildContext context,WidgetRef ref) {
    debugPrint(account?.phoneNumber);
    

    showCustomAlert(
      context: context,
      ref: ref,


      title: 'إرسال رسالة',
      message: 'هل تريد ارسال رسالة للعميل؟',
      confirmText: 'ارسال',
      cancelText: 'اغلاق',
      onConfirm: () {
        // Implement message functionality here
        Navigator.pop(context);
      },
     
      
    );
    
  }

  

  // Dialog for generating report
  void _showReportDialog(BuildContext context) {
    final theme = Theme.of(context);

    showCustomDialog(
      context: context,
      barrierDismissible: true,
      titleWidget: CustomAutoSizeText(
        text: 'تقرير الحساب',
        fontSize: 12,
        fontWeight: FontWeight.bold,
        colorText: theme.colorScheme.onPrimary,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAutoSizeText(
            text: 'هل تريد إنشاء تقرير عن الحساب: ${account?.name ?? "هذا الحساب"}',
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
                height: 30,
                text: 'إنشاء تقرير',
                
              ),
              TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: CustomAutoSizeText(
              text: 'إلغاء',
              colorText: theme.colorScheme.onSurface,
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