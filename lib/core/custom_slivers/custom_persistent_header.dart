import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/responsive_notifier.dart';

class CustomPersistentHeader extends ConsumerWidget {
  final Widget child;
  final double maxHeight;
  final double minHeight;
  
  final bool showShadowOnOverlap;
  final bool pinned;
  final bool floating;

  const CustomPersistentHeader({
    super.key,
    required this.child,
    required this.maxHeight,
    required this.minHeight,
    
    this.showShadowOnOverlap = true,
    this.pinned = true,
    this.floating = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final responsive = ref.watch(responsiveProvider);

    return SliverPersistentHeader(
      pinned: pinned,
      floating: floating,
      delegate: _CustomSliverDelegate(
        child: child,
        maxHeight: responsive.h(maxHeight ),
        minHeight: responsive.h(minHeight),
        
      ),
    );
  }
}

class _CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;
  

  _CustomSliverDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // final progress = (shrinkOffset / (maxHeight - minHeight)).clamp(0.0, 1.0);
    // print('shrinkOffset: $shrinkOffset , overlapsContent: $overlapsContent , progress: $progress');

    // return Container(
    //   decoration: BoxDecoration(
    //     color: backgroundColor,
    //     borderRadius: BorderRadius.only(
    //       bottomLeft: Radius.circular(borderRadius),
    //       bottomRight: Radius.circular(borderRadius),
    //     ),
    //     boxShadow: showShadowOnOverlap && overlapsContent
    //         ? [BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1)]
    //         : null,
    //   ),
    //   child: Opacity(
    //     opacity: 1 - (progress * 0.2), // Gradual fade-out effect
    //     child: Transform.scale(
    //       scale: 1 - (progress * 0.05), // Gradual scaling effect
    //       child: child,
    //     ),
    //   ),
    // );
    return child;
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant _CustomSliverDelegate oldDelegate) {
    return oldDelegate.maxHeight != maxHeight ||
        oldDelegate.minHeight != minHeight ||
        oldDelegate.child != child ;
       
  }
}