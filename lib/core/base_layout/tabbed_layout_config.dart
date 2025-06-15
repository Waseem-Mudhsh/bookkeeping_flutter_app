import 'package:flutter/material.dart';

import '../widgets/custom_tab_bar.dart';

class TabbedLayoutConfig {

  final List<Widget> tabViews;
  final CustomTabBar tabBar;
  final List<Tab> tabs;
  final int initialTabIndex;
  final bool hasLeading;
  final String? title;
  final List<Widget>? actions;
  final double? toolbarHeight;
  
  

  const TabbedLayoutConfig({
      required this.title,
      required this.toolbarHeight,
      required this.hasLeading,
    required this.tabs,
    required this.tabViews,
    required this.tabBar,
    this.initialTabIndex = 0,
    
    this.actions,
  });
}