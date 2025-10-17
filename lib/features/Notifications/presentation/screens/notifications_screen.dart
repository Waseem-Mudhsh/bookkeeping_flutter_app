import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/features/Notifications/presentation/screens/notification_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/custom_auto_size_text.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    return BaseLayoutScreen(
      body: BuildNonTabbarLayout(
        titleWidget: CustomAutoSizeText(
          text: 'الإشعارات',
          style: theme.textTheme.bodyMedium,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          colorText: theme.colorScheme.primary,
        ),
        slivers: [
          SliverToBoxAdapter(
            child: ResponsiveSpace(height: 16),
          ),
          const NotificationSection(),
        ],
      ),
    );
  }
}
