import 'package:flutter/material.dart';

import '../../widgets/custom_tab_bar.dart';

class TabBarSliverDelegate extends SliverPersistentHeaderDelegate   {
  final CustomTabBar tabBar;
  final Color color;
  final double? minExtentOverride;
  final double? maxExtentOverride;
  

  TabBarSliverDelegate({
    required this.tabBar,
    required this.color,
    this.minExtentOverride,
    this.maxExtentOverride
  }): assert(
          minExtentOverride == null || minExtentOverride <= (maxExtentOverride ?? tabBar.preferredSize.height),
          'minExtent cannot be larger than maxExtent',
        );

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade400, width: 1),
        
          
        ),
        
        child: SizedBox.expand(
          child: Padding(
            padding:  EdgeInsetsDirectional.symmetric(horizontal: 4, vertical: 4),
            child: tabBar,
          ),
        ),
      ),
    );
  }

  @override
  double get minExtent => minExtentOverride ?? tabBar.preferredSize.height;

  @override
  double get maxExtent => maxExtentOverride ?? tabBar.preferredSize.height;
  @override
  bool shouldRebuild(TabBarSliverDelegate oldDelegate) {
   return tabBar != oldDelegate.tabBar || 
           color != oldDelegate.color ||
           minExtent != oldDelegate.minExtent ||
           maxExtent != oldDelegate.maxExtent;
  }
  Widget buildSliver(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: this,
      
    );
  }
}