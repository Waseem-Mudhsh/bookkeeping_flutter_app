import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/screens/accounts_screen.dart';
import 'package:bookkeeping_flutter_app/features/Notifications/presentation/screens/notifications_screen.dart';
import 'package:bookkeeping_flutter_app/features/Notifications/presentation/widgets/custom_notification_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../core/utils/route_names.dart';
import '../../../../core/widgets/custom_auto_size_text.dart';
import '../../../Notifications/domain/entities/notification_model.dart';

// Add this import for mainAccountsProvider
final List<NotificationModel> mockNotifications = [
  NotificationModel(
    id: 'al1',
    message: 'رصيد العميل محمد تجاوز الحد المسموح به!',
    type: NotificationType.warning,
    onPressed: () => debugPrint('Top up cash'),
    date: DateTime.now(),
  ),
  NotificationModel(
    id: 'al2',
    message: 'تمت إضافة حساب جديد: محمد علي',
    type: NotificationType.info,
    onPressed: () => debugPrint('Pay electricity bill'),
  ),
  NotificationModel(
    id: 'al3',
    message: 'تنبيه أمني: تم تسجيل دخول من جهاز جديد.',
    type: NotificationType.critical,
    onPressed: () => debugPrint('Review security settings'),
    date: DateTime.now().subtract(const Duration(hours: 2)),
  ),
];

class FinanceScreen extends ConsumerWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    List<NotificationModel> mockAlerts = mockNotifications;

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
            notificationCount: mockAlerts.length,
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        NotificationsScreen(mockNotifications: mockAlerts),
              ),
            );

            debugPrint('Notifications button pressed');
            },
          )
        ],
        slivers: [
          SliverToBoxAdapter(child: ResponsiveSpace(height: 16,),),
          SliverToBoxAdapter(child: AccountsScreen(),),
          
          
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
