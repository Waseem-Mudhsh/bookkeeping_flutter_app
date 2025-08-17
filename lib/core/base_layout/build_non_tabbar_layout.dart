import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../custom_slivers/custom_sliver_app_bar.dart';
import '../providers/responsive_notifier.dart';
import '../providers/theme_data_provider.dart';
import '../widgets/custom_auto_size_text.dart';

/// A layout widget for screens with a sliver app bar and a single scrollable area.
/// 
/// [slivers] must only contain sliver widgets (e.g., SliverList, SliverGrid, SliverToBoxAdapter).
/// Passing non-sliver widgets will cause a runtime error.
class BuildNonTabbarLayout extends ConsumerWidget {
  final String? title;
  final List<Widget>? actions;
  final double? toolbarHeight;
  final PreferredSize? bottom;
  final bool hasLeading;
  final List<Widget> slivers;

  const BuildNonTabbarLayout({
    super.key,
    this.title,
    this.actions,
    this.toolbarHeight,
    this.bottom,
    this.hasLeading = false,
    required this.slivers,
  }); 

@override
Widget build(BuildContext context, WidgetRef ref) {
  final theme = ref.watch(themeDataProvider);
  final responsive = ref.watch(responsiveProvider);

  return CustomScrollView(
   
    physics: const ClampingScrollPhysics(),
    slivers: [
      CustomSliverAppBar(
        toolbarHeight: toolbarHeight ?? responsive.h(50),
        hasLeading: hasLeading,
        title: CustomAutoSizeText(
          text: title ?? '',
          style: theme.textTheme.bodyMedium,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
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
