import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_horizontal_list_view.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/screens/account_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/accounts_list_section.dart';





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
            
            AccountsListSection(
             
              onAccountTap: (account) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => AccountDetailsScreen(account: account),
                  ),
                );
                
                debugPrint('Account tapped: ${account.name}');
              },
              onAddAccount: () {
                debugPrint('Add account from list pressed');
              },
            ),
            AccountsListSection(
              
              onAccountTap: (account) {
                
                debugPrint('Account tapped: ${account.name}');
              },
              onAddAccount: () {
                debugPrint('Add account from list pressed');
              },
            ),
            AccountsListSection(
             
              onAccountTap: (account) {
                
                debugPrint('Account tapped: ${account.name}');
              },
              onAddAccount: () {
                debugPrint('Add account from list pressed');
              },
            ),
            AccountsListSection(
              
              onAccountTap: (account) {
               
                debugPrint('Account tapped: ${account.name}');
              },
              onAddAccount: () {
                debugPrint('Add account from list pressed');
              },
            ),
            AccountsListSection(
              
              onAccountTap: (account) {
                
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


