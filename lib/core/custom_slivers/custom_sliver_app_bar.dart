import 'package:bookkeeping_flutter_app/core/providers/theme_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/responsive_notifier.dart';

class CustomSliverAppBar extends ConsumerWidget {
  final Widget? title;
  final double? expandedHeight;
  final List<Widget>? actions;
  final FlexibleSpaceBar? flexibleSpaceContent;
  final bool pinned;
  final bool floating;
  final bool snap;
  final bool hasLeading;
  final Color? backgroundColor;
  final  PreferredSize? bottom;
  final bool centerTitle;
  final ShapeBorder? shape;
  final double? toolbarHeight;

  const CustomSliverAppBar({
    super.key,
     this.title,
    this.expandedHeight,
    this.actions,
    this.flexibleSpaceContent,
    this.pinned = true,
    this.floating = false,
    this.snap = false,
    this.hasLeading=false,
    this.backgroundColor,
    this.bottom,
    this.centerTitle = false, 
    this.shape,
    this.toolbarHeight
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final responsive = ref.watch(responsiveProvider);
    return SliverAppBar(
      titleSpacing:0.0 ,
      title:title ,
      centerTitle: centerTitle,
      expandedHeight: expandedHeight ?? 0,
      toolbarHeight: title != null ? toolbarHeight ?? responsive.h(50) :  0,
      pinned: pinned,
      floating: floating,
      snap: snap,
      leading:hasLeading ?  Builder(
      builder: (context) {
        return IconButton(
          icon: const Icon(Icons.menu),
          color: theme.colorScheme.primary,
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      },
    ): null,
      actions: actions,
      actionsPadding: responsive.paddingSym(h:16,),
      // backgroundColor: backgroundColor ?? theme.colorScheme.secondary,
      flexibleSpace: flexibleSpaceContent ,
      bottom: bottom ,
      shape:shape ?? Border(bottom: BorderSide(color: Colors.grey.shade200, width: 0.5)),
    );
  }
}
