import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/features/Notifications/domain/entities/notification_model.dart';
import 'package:bookkeeping_flutter_app/features/Notifications/presentation/screens/notification_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';

class NotificationsScreen extends ConsumerWidget {
  final List<NotificationModel> mockNotifications;
  const NotificationsScreen(
    {super.key, required this.mockNotifications});
    
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.watch(responsiveProvider);
    final theme = ref.watch(themeDataProvider);
    return BaseLayoutScreen(
      
      body: BuildNonTabbarLayout(
        title: 'الإشعارات',
       
        slivers: [
          SliverToBoxAdapter(child: ResponsiveSpace(height: 16,),),
          
          SliverToBoxAdapter(
            child: Padding(
              padding: responsive.paddingAll(responsive.w(16)),
              child: NotificationSection(
                mockNotifications: mockNotifications,
                 theme: theme,
                  responsive: responsive),
            ),
          )

        ])
    );
  }
}
