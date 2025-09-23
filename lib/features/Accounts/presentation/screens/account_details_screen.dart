//
// File: lib/presentation/account/account_details_screen.dart
// The main screen that ties everything together.
//
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_overlay.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_segmented_button.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/widgets/account_actions_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/base_layout/base_layout_screen.dart';
import '../../../../core/base_layout/build_non_tabbar_layout.dart';
import '../../../../core/utils/route_names.dart';
import '../../../../core/widgets/custom_auto_size_text.dart';
import '../../../../core/widgets/responsive_space.dart';
import '../../../Transactions/presentation/widgets/transaction_list.dart';
import '../../domain/entities/account.dart';
import '../providers/account_provider.dart';
import '../widgets/balance_card.dart';



class AccountDetailsScreen extends ConsumerWidget {
  final Account? account;

  const AccountDetailsScreen({super.key, this.account});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final responsive = ref.responsive;
   
    

    return BaseLayoutScreen(
      body: BuildNonTabbarLayout(
       
        titleWidget: _buildHeader(theme),
         toolbarHeight: responsive.h(60),
        actions:[ 

      _buildPopupMenuButton(context, ref, theme)

        ],
       slivers: [
          SliverToBoxAdapter(
            child: ResponsiveSpace( height: 16,),
          ),
          SliverToBoxAdapter(
            child: CustomSegmentedButton(
              nameButtons: ['يمني', 'سعودي', 'دولار',],
              contentButtons:[
                _buildTransactionListByCurrency(),
                _buildTransactionListByCurrency(),
                _buildTransactionListByCurrency(),
              
              ] ,
               theme: theme, responsive: responsive),
          ),
         
       ],
        
       
        hasLeading: false,
        
      ),
      // FloatingActionButton.extended for adding new transactions
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: theme.colorScheme.secondaryContainer,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionSubRoutes.create.screenAdd(account!.id, ),
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
              fontSize: 14,
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
  Widget _buildPopupMenuButton(BuildContext context, WidgetRef ref, ThemeData theme){
    return PopupMenuButton(
      itemBuilder: 
        (context) {
          return [
            PopupMenuItem(
              value: 'edit',
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.edit, color: theme.colorScheme.onSurface),
                  const SizedBox(width: 8),
                  CustomAutoSizeText(text: 'تعديل الحساب',
                  style: theme.textTheme.bodyMedium,
                  fontSize: 12,),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'delete',
               child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.delete, color: theme.colorScheme.onSurface),
                  const SizedBox(width: 8),
                  CustomAutoSizeText(text: 'حذف الحساب',
                  style: theme.textTheme.bodyMedium,
                  fontSize: 12,),
                ],
              ),
            ),
          ];
        }, onSelected: (value) {
          if (value == 'edit') {
            // Handle edit
          } else if (value == 'delete') {
            // Show confirmation dialog before deleting
           showConfirmationDialog(
              responsive: ref.responsive,
              theme: theme,
              context: context,
              title: 'تأكيد الحذف',
              content: CustomAutoSizeText(
                text: 'هل أنت متأكد أنك تريد حذف هذا الحساب؟',
                style: theme.textTheme.bodyMedium,
                fontSize: 12,
              ),
              onConfirm: () {
                ref.read(accountViewModelProvider.notifier).deleteAccount(account!.id);
                Navigator.pop(context); // Close the dialog
              },
             
            );
          
            // Handle delete
          }
        },
        icon: CustomHugeIcon(
          icon:HugeIcons.strokeRoundedMoreVertical,
          color: theme.colorScheme.primary,
          size: 20,),
        );
  }
  Widget _buildTransactionListByCurrency(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveSpace( height: 16,),
        BalanceCard(account: account!,),
        ResponsiveSpace(height: 16),
        AccountActionsRow(account:  account!, isCompact: true,),
        ResponsiveSpace(height: 16),
        TransactionList(account: account!),


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