import 'package:bookkeeping_flutter_app/core/utils/responsive_values.dart';
import 'package:flutter/material.dart';

/// A safe container for tab views in BuildTabBarLayout.
/// - Always provides a finite height for columns or custom content.
/// - Handles scrolling content safely.
/// - Use this as a wrapper for your tab content.
class CustomTabViewContainer extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final Widget child;
  final ResponsiveValues responsive;

  const CustomTabViewContainer({
    super.key,
    required this.child,
    this.padding,

    required this.responsive,
  });

  @override
  Widget build(BuildContext context) {
    // You can adjust minHeight/maxHeight as needed for your design.
    return Padding(
      padding: padding ?? responsive.paddingAll(16),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: child,
      ),
    );
  }
}
