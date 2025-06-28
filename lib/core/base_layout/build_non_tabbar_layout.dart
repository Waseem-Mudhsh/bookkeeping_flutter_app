import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../custom_slivers/custom_sliver_app_bar.dart';
import '../providers/responsive_notifier.dart';
import '../providers/theme_data_provider.dart';
import '../widgets/custom_auto_size_text.dart';

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

    // Access the responsive
    return NestedScrollView(
      clipBehavior: Clip.antiAlias,
      floatHeaderSlivers: true,
      physics: const ClampingScrollPhysics(),

      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: CustomSliverAppBar(
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
     ) ];
    
      },
      body: Builder(
        builder: (context) {
          return CustomScrollView(
            physics: const ClampingScrollPhysics(),
            // controller: PrimaryScrollController.of(context),
            slivers: [
              // لمنع تداخل المحتوى مع AppBar
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              ...slivers,
            ],
          );
        }
      ),
      
    );
  }
}
