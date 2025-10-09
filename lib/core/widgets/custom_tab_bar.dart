import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


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
    final theme = ref.theme;
    final responsive = ref.responsive;
    return TabBar(
      controller: tabController,
      isScrollable: isScrollable,
      dividerColor: Colors.transparent,

      tabs: tabs,
      indicatorAnimation: TabIndicatorAnimation.elastic,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding:  responsive.paddingSym(h: 4, v: 4),
          // indicatorWeight: 0.5,
          mouseCursor: MouseCursor.defer,
          physics: const ClampingScrollPhysics(),
          labelColor: theme.colorScheme.onPrimary,
          unselectedLabelColor: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
           indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
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
