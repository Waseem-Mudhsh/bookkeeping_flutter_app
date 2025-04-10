import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/responsive_notifier.dart';

extension ResponsiveSlivers on WidgetRef {
  // Responsive SliverAppBar with more customization options
  SliverAppBar responsiveSliverAppBar(
    String title, {
    bool pinned = true,
    bool floating = true,
    bool snap = false,
    double? expandedHeight,
    List<Widget>? actions,
    Widget? flexibleSpace,
  }) {
    final responsive = watch(responsiveProvider);
    
    return SliverAppBar(
      title: Text(title, style:  TextStyle(fontSize: responsive.sp(20))),
      expandedHeight: expandedHeight ?? responsive.w(56),
      pinned: pinned,
      floating: floating,
      snap: snap,
      toolbarHeight: responsive.w(56),
      actions: actions,
      flexibleSpace: flexibleSpace,
      elevation: 0,
    );
  }

  // Responsive SliverPadding with additional padding options
  SliverPadding responsiveSliverPadding({
    required Widget sliver,
    double all = 0,
    double horizontal = 0,
    double vertical = 0,
    EdgeInsets? customPadding,
  }) {
    final responsive = watch(responsiveProvider);
    return SliverPadding(
      padding: customPadding ??
          (all > 0
              ? responsive.paddingAll(all)
              : responsive.paddingSym(h: horizontal, v: vertical)),
      sliver: sliver,
    );
  }

  // Responsive SliverToBoxAdapter with optional alignment
  SliverToBoxAdapter responsiveSliverBox({
    required Widget child,
    Alignment alignment = Alignment.center,
  }) {
    return SliverToBoxAdapter(
      child: Align(
        alignment: alignment,
        child: child,
      ),
    );
  }

  // Responsive SliverList with optional spacing between items
  SliverList responsiveSliverList({
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
    double spacing = 0,
  }) {
    final responsive = watch(responsiveProvider);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: index == itemCount - 1 ? 0 : responsive.h(spacing),
            ),
            child: itemBuilder(context, index),
          );
        },
        childCount: itemCount,
        addAutomaticKeepAlives: true,
      ),
    );
  }

  // Responsive SliverGrid with additional customization options
  Widget responsiveSliverGrid({
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
    int crossAxisCount = 2,
    double childAspectRatio = 1.0,
    double spacing = 10,
    EdgeInsets? padding,
  }) {
    final responsive = watch(responsiveProvider);
    return SliverPadding(
      padding: padding ?? EdgeInsets.zero,
      sliver: SliverGrid(
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
      ),
    );
  }

  // Responsive SliverFillRemaining for filling remaining space
  SliverFillRemaining responsiveSliverFillRemaining({
    required Widget child,
    bool hasScrollBody = false,
  }) {
    return SliverFillRemaining(
      hasScrollBody: hasScrollBody,
      child: child,
    );
  }

  // Responsive SliverFillViewport for filling the viewport
  SliverFillViewport responsiveSliverFillViewport({
    required Widget Function(BuildContext, int) itemBuilder,
    required int itemCount,
    double viewportFraction = 1.0,
  }) {
    return SliverFillViewport(
      delegate: SliverChildBuilderDelegate(
        itemBuilder,
        childCount: itemCount,
      ),
      viewportFraction: viewportFraction,
    );
  }

  // Responsive SliverPersistentHeader with dynamic sizing
  SliverPersistentHeader responsiveSliverPersistentHeader({
    required Widget Function(BuildContext, double) builder,
    required double minHeightFactor,
    required double maxHeightFactor,
    bool? pinned ,
    bool? floating ,
  }) {
    final responsive = watch(responsiveProvider);

    return SliverPersistentHeader(
      pinned: pinned ?? true,
      floating: floating ?? true,
      delegate: _CustomSliverPersistentHeaderDelegate(
        builder: builder,
        minHeight: responsive.h(minHeightFactor),
        maxHeight: responsive.h(maxHeightFactor),
      ),
    );
  }
}

// Custom Delegate for SliverPersistentHeader
class _CustomSliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget Function(BuildContext, double) builder;
  final double minHeight;
  final double maxHeight;

  _CustomSliverPersistentHeaderDelegate({
    required this.builder,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / (maxExtent - minExtent);
    return builder(context, progress.clamp(0.0, 1.0));
  }

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

}