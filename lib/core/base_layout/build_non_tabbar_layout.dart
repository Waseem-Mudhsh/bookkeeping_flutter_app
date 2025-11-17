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
  final bool hasDrawer;
  final List<Widget> slivers;
  final double? padding;
  final ScrollPhysics? physics;
  final double? expandedHeight;
  final bool? floating;
  final bool? snap;
  final bool? pinned;
  final FlexibleSpaceBar? flexibleSpaceContent;


  const BuildNonTabbarLayout({
    super.key,
    this.titleWidget,
    this.actions,
    this.toolbarHeight,
    this.bottom,
    this.hasDrawer = false,
    required this.slivers,
    this.padding,
    this.physics,
    this.expandedHeight,
    this.floating,
    this.snap,
    this.pinned,
    this.flexibleSpaceContent,

  }); 

@override
Widget build(BuildContext context, WidgetRef ref) {
  
  final responsive = ref.responsive;

  return CustomScrollView(
   
    physics: physics ?? const ClampingScrollPhysics(),
    slivers: [
      CustomSliverAppBar(
        toolbarHeight:  responsive.h(toolbarHeight ?? 56),
        hasDrawer: hasDrawer,
        title: titleWidget,
        actions: actions,
        bottom: bottom,
        expandedHeight: expandedHeight,
        floating: floating ?? false,
        snap: snap ?? false,
        pinned: pinned ?? true,
        flexibleSpaceContent: flexibleSpaceContent,
      ),
      
      ...slivers.map((sliver) => SliverPadding(
          padding: responsive.paddingSym(h: padding ?? 16),
          sliver: sliver,
        )),
      
     
    ],
  );
}
}
