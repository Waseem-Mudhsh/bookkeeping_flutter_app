import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/widgets/accounts_list_section.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/screens/account_details_screen.dart';
import 'package:bookkeeping_flutter_app/features/Notifications/presentation/providers/notification_provider.dart';
import 'package:bookkeeping_flutter_app/features/Notifications/presentation/providers/notification_provider.dart';
import 'package:bookkeeping_flutter_app/features/Notifications/presentation/screens/notifications_screen.dart';
import 'package:bookkeeping_flutter_app/features/Notifications/presentation/widgets/custom_notification_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../core/utils/route_names.dart';
import '../../../../core/widgets/custom_auto_size_text.dart';

class FinanceScreen extends ConsumerWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final notificationCount = ref.watch(notificationProvider).length;
    final theme = ref.theme;

    return BaseLayoutScreen(
     
      body: BuildNonTabbarLayout(
        titleWidget: CustomAutoSizeText(
          text: 'الحسابات المالية',
          style: theme.textTheme.bodyMedium,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          colorText: theme.colorScheme.primary,
        ),
        actions: [
          
          CustomNotificationButton(
            notificationCount: notificationCount,
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationsScreen(),
              ),
            );

            debugPrint('Notifications button pressed');
            },
          )
        ],
        slivers: [
          SliverToBoxAdapter(child: ResponsiveSpace(height: 16,),),
          SliverToBoxAdapter(child: AccountsListSection(
            onAccountTap: (account) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AccountDetailsScreen(account: account)));
            },
            onAddAccount: () {
              // TODO: Implement search or filter logic
            },
          ),
        ),
          
          
        ]),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: theme.colorScheme.secondaryContainer,
        onPressed: () {
          Navigator.push(context,
                MaterialPageRoute(builder: (context) => AccountSubRoutes.create.screen));},
        label: CustomAutoSizeText(
          text: 'اضافة حساب جديد',
          // colorText: theme.colorScheme.onPrimary,
          fontSize: 12,
          style: theme.textTheme.bodyMedium,
          colorText: theme.colorScheme.onSecondaryContainer,
          ),
        icon:  CustomHugeIcon(
          icon: HugeIcons.strokeRoundedUserAdd01,
          size:20,
          color: theme.colorScheme.onSecondaryContainer,),
        // backgroundColor: theme.colorScheme.primary,
        // foregroundColor: theme.colorScheme.onPrimary,
       
        ),
        ) ;
         
        
  }

  

  
}
