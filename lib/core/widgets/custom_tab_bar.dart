import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/theme_data_provider.dart';

class CustomTabBar extends ConsumerWidget implements PreferredSizeWidget {
  final List<Tab> tabs;
  final TabController? tabController;
  final bool isScrollable;
  

  const CustomTabBar({
     required this.tabs,
     this.tabController,
      this.isScrollable = false,
     super.key
     });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    return TabBar(
      controller: tabController,
      isScrollable: isScrollable,
      dividerColor: Colors.transparent,

      tabs: tabs,
      indicatorAnimation: TabIndicatorAnimation.elastic,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
          // indicatorWeight: 0.5,
          
          labelColor: theme.colorScheme.onPrimary,
          unselectedLabelColor: Colors.grey.shade500,
           indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: theme.colorScheme.primary,
                      ),
          labelStyle: theme.textTheme.bodySmall!.copyWith(
            
            fontWeight: FontWeight.bold
          ),
          unselectedLabelStyle: theme.textTheme.bodySmall!.copyWith(
            
            fontWeight: FontWeight.w500
          ),
      );
  }
  
  @override
  
  Size get preferredSize => throw UnimplementedError();
  
  
}
