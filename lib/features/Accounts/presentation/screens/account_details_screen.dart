//
// File: lib/presentation/account/account_details_screen.dart
// The main screen that ties everything together.
//
import 'package:bookkeeping_flutter_app/core/base_layout/build_tab_bar_layout.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_overlay.dart';
import 'package:bookkeeping_flutter_app/features/Currencies/presentation/widgets/custom_show_balince.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/base_layout/base_layout_screen.dart';
import '../../../../core/base_layout/build_non_tabbar_layout.dart';
import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';
import '../../../../core/utils/route_names.dart';
import '../../../../core/widgets/custom_auto_size_text.dart';
import '../../../../core/widgets/custom_overlay.dart';
import '../../../../core/widgets/responsive_space.dart';
import '../../../Currencies/presentation/providers/currency_provider.dart';
import '../../../Transactions/presentation/widgets/transaction_list.dart';
import '../../domain/entities/account.dart';
import '../providers/account_provider.dart';


class AccountDetailsScreen extends ConsumerWidget {
  final Account? account;

  const AccountDetailsScreen({super.key, this.account});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
   
    

    return BaseLayoutScreen(
      body: BuildNonTabbarLayout(
       
        title: account!.name,
        actions:[ 
        
        ResponsiveSpace(width: 16),
        PopupMenuButton(itemBuilder: 
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
        }),

        ],
       slivers: [
          SliverToBoxAdapter(
            child: ResponsiveSpace(height: 16),
          ),
         SliverToBoxAdapter(
          child: CustomShowBalince(account:account!),
         ),
         SliverToBoxAdapter(
          child: ResponsiveSpace(height: 16),
         ),
         SliverToBoxAdapter(
          child: TransactionList(
            account: account!,
          ),
         ),
       ],
        
       
        hasLeading: false,
        
      ),
      // FloatingActionButton.extended for adding new transactions
      floatingActionButton: FloatingActionButton.extended(
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
          colorText: theme.colorScheme.onPrimary,
          fontSize: 12,
          style: theme.textTheme.bodyMedium,
        ),
        icon: Icon(Icons.add, color: theme.colorScheme.onPrimary),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )
      ),
      // bottomNavigationBar: AccountBalanceInfo(account: account!),
     
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