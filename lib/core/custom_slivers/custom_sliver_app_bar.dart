import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomSliverAppBar extends ConsumerWidget {
  final Widget? title;
  final double? expandedHeight;
  final List<Widget>? actions;
  final FlexibleSpaceBar? flexibleSpaceContent;
  final bool pinned;
  final bool floating;
  final bool snap;
  final bool hasDrawer;
  final Color? backgroundColor;
  final PreferredSize? bottom;
  final bool centerTitle;
  final ShapeBorder? shape;
  final double? toolbarHeight;
  final Widget? leadingWidget;

  const CustomSliverAppBar({
    super.key,
    this.title,
    this.expandedHeight,
    this.actions,
    this.flexibleSpaceContent,
    this.pinned = true,
    this.floating = false,
    this.snap = false,
    this.hasDrawer = false,
    this.backgroundColor,
    this.bottom,
    this.centerTitle = false,
    this.shape,
    this.toolbarHeight,
    this.leadingWidget,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final responsive = ref.responsive;
    
    return SliverAppBar(
      
      // collapsedHeight: toolbarHeight ?? responsive.h(56),
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      titleSpacing: 0.0,
      title: title,
      centerTitle: centerTitle,
      expandedHeight: expandedHeight,
      toolbarHeight: toolbarHeight ?? responsive.h(56),
      pinned: pinned,
      floating: floating,
      snap: snap,
      scrolledUnderElevation: 4.0,
      // يضيف ظلاً خفيفاً عندما يبدأ المحتوى بالتمرير تحته
      forceElevated: true,
     

      // primary: false,
      leading:
          hasDrawer
              ? Builder(
                builder: (context) {
                  return IconButton(
                    icon: const CustomHugeIcon(
                      icon: HugeIcons.strokeRoundedMenuTwoLine,
                    ),
                    color: theme.colorScheme.primary,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              )
              : leadingWidget,
      actions: actions,
      actionsPadding: responsive.paddingOnly(left: 16),

      flexibleSpace: flexibleSpaceContent ?? const FlexibleSpaceBar(),
      bottom:
          bottom ??
          const PreferredSize(preferredSize: Size.zero, child: SizedBox()),
      shape:
          shape ??
          Border(
            bottom: BorderSide(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
              width: 0.5,
            ),
          ),
    );
  }
}
