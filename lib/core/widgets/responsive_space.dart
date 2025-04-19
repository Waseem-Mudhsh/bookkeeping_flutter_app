import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/responsive_notifier.dart';

class ResponsiveSpace extends ConsumerWidget {
  final double? width;
  final double? height;
  final Widget? child;

  const ResponsiveSpace({
    super.key,
    this.width,
    this.height,
    this.child,
  }) : assert(width != null || height != null || child != null,
           'Must provide width, height, or child');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.watch(responsiveProvider);

    return SizedBox(
      width: width != null ? responsive.w(width!) : null,
      height: height != null ? responsive.h(height!) : null,
      child: child,
    );
  }
}