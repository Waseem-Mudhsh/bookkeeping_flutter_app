import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../custom_slivers/custom_sliver_app_bar.dart';

class BuildTabBarLayout extends ConsumerStatefulWidget {
  final ScrollPhysics? physics;
  final List<Widget> tabViews;
  final List<Tab> tabs;
  final int initialTabIndex;
  final bool hasLeading;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final double? toolbarHeight;

  const BuildTabBarLayout({
    super.key,
    this.actions,
    this.physics,
    required this.tabViews,
    required this.tabs,
    required this.initialTabIndex,
    required this.hasLeading,
    required this.toolbarHeight,
    required this.titleWidget,
  });

  @override
  ConsumerState<BuildTabBarLayout> createState() => _TabbedLayoutState();
}

class _TabbedLayoutState extends ConsumerState<BuildTabBarLayout>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final PageController _pageController;
  final List<ScrollController> _scrollControllers = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
    _pageController = PageController(initialPage: widget.initialTabIndex);

    for (int i = 0; i < widget.tabs.length; i++) {
      _scrollControllers.add(ScrollController());
    }

    _tabController.addListener(_syncTabToPage);
  }

  void _syncTabToPage() {
    if (_tabController.indexIsChanging) {
      _pageController.jumpToPage(_tabController.index);
    }
  }

  void _onPageChanged(int index) {
    if (_currentIndex != index) {
      setState(() => _currentIndex = index);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollControllers[index].hasClients) {
          _scrollControllers[index].jumpTo(0);
        }
      });
      _tabController.animateTo(index);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    for (var controller in _scrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ref.responsive;
    return NestedScrollView(
      physics: widget.physics ?? const ClampingScrollPhysics(),
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: CustomSliverAppBar(
              toolbarHeight: widget.toolbarHeight ?? responsive.h(116),
              hasLeading: widget.hasLeading,
              title: widget.titleWidget,
              actions: widget.actions,
              bottom: PreferredSize(
                preferredSize: Size.zero,
                child: Padding(
                  padding: responsive.paddingOnly(
                    top: 8,
                    bottom: 8,
                    left: 16,
                    right: 16,
                  ),
                  child: Container(
                    height: responsive.h(50),
                    padding: responsive.paddingSym(h: 4, v: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade400, width: 1),
                    ),
                    child: CustomTabBar(
                      tabController: _tabController,
                      tabs: widget.tabs,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ];
      },
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemCount: widget.tabViews.length,
        itemBuilder: (context, index) {
          final tabView = widget.tabViews[index];
          return CustomScrollView(
            controller: _scrollControllers[index],
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
              ),
              // If tabView is already a sliver, use it directly; otherwise, wrap in SliverToBoxAdapter
              if (tabView is SliverList ||
                tabView is SliverGrid ||
                tabView is SliverFillRemaining ||
                tabView is SliverToBoxAdapter)
              tabView
            else
              SliverToBoxAdapter(child: tabView),
            ],
          );
        },
      ),
    );
  }
}
