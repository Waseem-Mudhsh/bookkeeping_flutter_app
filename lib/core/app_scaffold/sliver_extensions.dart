
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/responsive_notifier.dart';
import '../providers/theme_data_provider.dart';

extension ResponsiveSlivers on WidgetRef {
  // Responsive SliverAppBar with more customization options
  SliverAppBar responsiveSliverAppBar(
     {
    Widget? title,
    bool pinned = true,
    bool floating = true,
    bool snap = false,
    double? expandedHeight,
    double? toolbarHeight,
    List<Widget>? actions,
    FlexibleSpaceBar ? flexibleSpace,
    Widget? leading,
    double? elevation,
    Color? backgroundColor,
    Color? foregroundColor,
    bool hasBorder = false
    
  }) {
    final responsive = watch(responsiveProvider);
    
    
    return SliverAppBar(
      shadowColor: backgroundColor,
      title: title ?? const Text(''),
      expandedHeight: responsive.w(expandedHeight ?? 56),
      toolbarHeight: responsive.w(toolbarHeight ?? 56),
      pinned: pinned,
      floating: floating,
      snap: snap,
      leading: leading,
      actions: actions,
      flexibleSpace: flexibleSpace,
      elevation: elevation ?? 0,
      backgroundColor: backgroundColor ?? Colors.transparent,
      foregroundColor: foregroundColor ?? Colors.transparent,
      shape: hasBorder ? Border(bottom:BorderSide(color:Colors.black12,width: 1)) : null,
     
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
    Alignment? alignment,
    Color? backgroundColor,
    bool hasBorder = false,
  }) {
    return SliverToBoxAdapter(
      child: Container(
       alignment:alignment ?? Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor?? Colors.transparent,
          border: hasBorder ? Border(bottom:BorderSide(color:Colors.black12,width: 1)) : null,
          ),
        child: child,
      ),
    );
  }

  // Responsive SliverList with optional spacing between items
  SliverList responsiveSliverList({
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
    double spacing = 0,
    Axis? scrollDirection,
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
  // Responsive SizeBox with returning a width or height
  

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
    Color? backgroundColor,
    bool? showShadowOnOverlap ,
  }) {
    final responsive = watch(responsiveProvider);
    final theme = watch(themeDataProvider);

    return SliverPersistentHeader(
      pinned: pinned ?? true,
      floating: floating ?? true,
      delegate: _CustomSliverPersistentHeaderDelegate(
        builder: builder,
        minHeight: responsive.h(minHeightFactor),
        maxHeight: responsive.h(maxHeightFactor),
        showShadowOnOverlap: showShadowOnOverlap ?? true,
        backgroundColor: backgroundColor ??theme.colorScheme.secondary,
      ),
    );
  }
}

// Custom Delegate for SliverPersistentHeader
class _CustomSliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget Function(BuildContext, double) builder;
  final double minHeight;
  final double maxHeight;
  final Color backgroundColor;
  final bool showShadowOnOverlap;

  _CustomSliverPersistentHeaderDelegate({
    required this.builder,
    required this.minHeight,
    required this.maxHeight,
    required this.backgroundColor,
    required this.showShadowOnOverlap ,
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
    return oldDelegate is _CustomSliverPersistentHeaderDelegate &&
        (oldDelegate.minHeight != minHeight ||
            oldDelegate.maxHeight != maxHeight ||
            oldDelegate.backgroundColor != backgroundColor ||
            oldDelegate.showShadowOnOverlap != showShadowOnOverlap);
  }


}
// Responsive SliverList with optional spacing between items