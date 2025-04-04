import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/responsive_notifier.dart';

extension ResponsiveSlivers on WidgetRef {
  // Responsive SliverAppBar
  SliverAppBar responsiveSliverAppBar(String title, {bool pinned = true}) {
    final responsive = watch(responsiveProvider);
    return SliverAppBar(
      title: Text(title,),
      expandedHeight: responsive.h(56),
      pinned: pinned,
      floating: true,
      toolbarHeight: responsive.h(56),
    );
  }

  // Responsive SliverPadding
   SliverPadding responsiveSliverPadding({
    required Widget sliver,
    double all = 0,
    double horizontal = 0,
    double vertical = 0,
  }) {
    final responsive = watch(responsiveProvider);
    return SliverPadding(
      padding: all > 0
          ? responsive.paddingAll(all)
          : responsive.paddingSym(h: horizontal, v: vertical),
      sliver: sliver,
    );
  }

  // Responsive SliverToBoxAdapter
  SliverToBoxAdapter responsiveSliverBox({required Widget child}) {
    return SliverToBoxAdapter(child: child);
  }

  // Responsive SliverList
  SliverList responsiveSliverList({
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
  }) {
    final responsive = watch(responsiveProvider);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        itemBuilder,
        childCount: itemCount,
        addAutomaticKeepAlives: true,
      ),
    );
  }

  // Responsive SliverGrid
  SliverGrid responsiveSliverGrid({
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
    int crossAxisCount = 2,
    double childAspectRatio = 1.0,
    double spacing = 10,
  }) {
    final responsive = watch(responsiveProvider);
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        mainAxisSpacing: responsive.h(spacing),
        crossAxisSpacing: responsive.w(spacing),
      ),
      delegate: SliverChildBuilderDelegate(
        itemBuilder,
        childCount: itemCount,
      ),
    );
  }
}