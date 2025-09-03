import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../custom_slivers/custom_sliver_app_bar.dart';

/// A layout widget for screens with a sliver app bar and a single scrollable area.
/// 
/// [slivers] must only contain sliver widgets (e.g., SliverList, SliverGrid, SliverToBoxAdapter).
/// Passing non-sliver widgets will cause a runtime error.
class BuildNonTabbarLayout extends ConsumerWidget {
  final Widget? titleWidget;
  final List<Widget>? actions;
  final double? toolbarHeight;
  final PreferredSize? bottom;
  final bool hasLeading;
  final List<Widget> slivers;

  const BuildNonTabbarLayout({
    super.key,
    this.titleWidget,
    this.actions,
    this.toolbarHeight,
    this.bottom,
    this.hasLeading = false,
    required this.slivers,
  }); 

@override
Widget build(BuildContext context, WidgetRef ref) {
  
  final responsive = ref.responsive;

  return CustomScrollView(
   
    physics: const ClampingScrollPhysics(),
    slivers: [
      CustomSliverAppBar(
        toolbarHeight: toolbarHeight ?? responsive.h(50),
        hasLeading: hasLeading,
        title: titleWidget,
        actions: actions,
        bottom: bottom,
      ),
      
      ...slivers.map((sliver) => SliverPadding(
          padding: responsive.paddingSym(h: 16),
          sliver: sliver,
        )),
      
     
    ],
  );
}
}
