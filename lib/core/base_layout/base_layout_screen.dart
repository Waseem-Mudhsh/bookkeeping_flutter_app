import 'package:bookkeeping_flutter_app/core/base_layout/build_tab_bar_layout.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/tabbed_layout_config.dart';
import 'package:bookkeeping_flutter_app/core/custom_slivers/custom_sliver_app_bar.dart';
import 'package:bookkeeping_flutter_app/core/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/responsive_notifier.dart';
import '../providers/theme_data_provider.dart';

class BaseLayoutScreen extends ConsumerWidget {
  final List<Widget>? slivers;
  final TabbedLayoutConfig? tabbedConfig;
  final CustomSliverAppBar? header;
  final List<Widget>? sliversHeader;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final ScrollPhysics? scrollPhysics;
  final String? routeName;

  const BaseLayoutScreen({
    super.key,
    this.slivers,
    this.tabbedConfig,
    this.header,
    this.sliversHeader,
    this.floatingActionButton,
    this.drawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.scrollPhysics,
    this.routeName,
  }) : assert(
         (slivers != null && tabbedConfig == null) ||
             (slivers == null && tabbedConfig != null),
         'Provide either slivers or tabbedConfig, not both',
       );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final responsive = ref.watch(responsiveProvider);
    final physics = scrollPhysics ?? const ClampingScrollPhysics();

    return Scaffold(
      // backgroundColor: backgroundColor ?? theme.scaffoldBackgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButton: floatingActionButton,
      drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,

      body: SafeArea(
        top: responsive.orientation == Orientation.portrait ? true : false,
        child:
            tabbedConfig != null
                ? _buildTabBarLayout()
                : _buildNonTabBarLayout(context, physics, theme, responsive),
      ),
    );
  }

  Widget _buildNonTabBarLayout(
    BuildContext context,
    ScrollPhysics physics,
    ThemeData theme,
    ResponsiveValues responsive,
  ) {
    return NestedScrollView(
      physics: physics,
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [if (header != null) header!, ...sliversHeader ?? []];
      },
      body: CustomScrollView(
        physics: physics,
        slivers: [
          if (header == null)
            SliverPadding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            ),

          ...slivers!,
          SliverPadding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBarLayout() 
  {
   
    return BuildTabBarLayout(
      physics: scrollPhysics?? const ClampingScrollPhysics(),
      sliversHeader: sliversHeader ?? [],
      actions: tabbedConfig!.actions ?? [],
      tabViews: tabbedConfig!.tabViews,
      tabs: tabbedConfig!.tabs,
      initialTabIndex: tabbedConfig!.initialTabIndex,
      hasLeading: tabbedConfig!.hasLeading,
      toolbarHeight: tabbedConfig!.toolbarHeight,
      title: tabbedConfig!.title,
    );
  }
}
