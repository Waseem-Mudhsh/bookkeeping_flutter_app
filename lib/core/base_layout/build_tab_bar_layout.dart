// import 'package:bookkeeping_flutter_app/core/custom_slivers/custom_sliver_app_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart' show RenderSliver;
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../providers/responsive_notifier.dart';

// class BuildTabView extends ConsumerWidget {
//   final bool? hasTabBar;
//   final CustomSliverAppBar? customSliverAppBar;
//   final List<Widget>? sliversHeader;
//   final List<Widget> sliverBady;
  

//   const BuildTabView({
//     super.key,
//     required this.hasTabBar,
//     this.customSliverAppBar,
//     this.sliversHeader,
//     required this.sliverBady,
    
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final responsive = ref.watch(responsiveProvider);
//     return 
      
//        NestedScrollView(
       
//         floatHeaderSlivers: true,
//         headerSliverBuilder: (context, innerBoxIsScrolled) {
//           return [
//            customSliverAppBar!,
//             ...sliversHeader ?? [],
//           ];
            
//         },
             
//         // body:  hasTabBar! 
//         //     ? TabBarView(children: sliverBady)
//         //     : Column(children: sliverBady),
//         body: hasTabBar!
//             ? TabBarView(children: sliverBady)
//             : CustomScrollView(
//                 slivers: [
//                   ...sliverBady.map((widget) {
//                       if (widget is RenderObjectWidget && widget.createRenderObject(context) is RenderSliver) {
//                       return widget;
//                     } else {
//                       return SliverToBoxAdapter(child: widget);
//                     }
//                   }),
//                 ],
//               ),
//       );
    
//   }
// }
// import 'package:bookkeeping_flutter_app/core/custom_slivers/custom_sliver_app_bar.dart';
// import 'package:bookkeeping_flutter_app/core/widgets/custom_tab_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../base_layout/tabbed_layout_config.dart';
// import '../providers/theme_data_provider.dart';

// class BuildTabView extends ConsumerStatefulWidget {
//   final ScrollPhysics? physics;
//   final TabbedLayoutConfig tabBarConfig;
  
//   const BuildTabView(
//     {super.key,
//      this.physics,
//      required this.tabBarConfig,
     
//      });
  
//   @override
//   ConsumerState<BuildTabView> createState() => BuildTabViewState();
// }

// class BuildTabViewState extends ConsumerState<BuildTabView> {
//   late PageController pageController;
//    int currentIndex =0;
//   @override
//   Widget build(BuildContext context) {
//     final theme= ref.watch(themeDataProvider);
//     return NestedScrollView(
//        physics: widget.physics,
//         floatHeaderSlivers: true,
//       headerSliverBuilder: (context, innerBoxIsScrolled) {
//         return[
//           CustomSliverAppBar(
//             hasLeading: widget.tabBarConfig.hasLeading,
//             title: widget.tabBarConfig.title,
//             actions: widget.tabBarConfig.actions,
            
//             expandedHeight: widget.tabBarConfig.expandedHeight,
//             bottom: PreferredSize(
//               preferredSize: const Size.fromHeight(0), 
//               child:TabBar(

//       tabs: widget.tabBarConfig.tabs,
//       indicatorAnimation: TabIndicatorAnimation.elastic,
//           indicatorSize: TabBarIndicatorSize.tab,
//           indicatorWeight: 0.5,
//           indicatorColor: theme.colorScheme.primary,
//           labelColor: theme.colorScheme.onPrimary,
//           unselectedLabelColor: Colors.grey.shade400,
//            indicator: BoxDecoration(
//                       borderRadius: BorderRadius.circular(6.0),
//                       color: theme.colorScheme.primary,),
//           labelStyle: theme.textTheme.bodySmall!.copyWith(
//             fontWeight: FontWeight.bold
//           ),
//            onTap: (index) {
//     setState(() => currentIndex = index);
//     pageController.jumpToPage(index);
//   },
//       )
//               ),
         
//           )
//         ];
//       },
//        body: PageView(
//          physics: widget.physics,
//          controller: pageController,
//          scrollDirection: Axis.horizontal,
//          children: widget.tabBarConfig.tabViews,
//        ));
//   }
// }

import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../custom_slivers/custom_sliver_app_bar.dart';
import '../providers/responsive_notifier.dart';
import '../providers/theme_data_provider.dart';

class BuildTabBarLayout extends ConsumerStatefulWidget {
  final ScrollPhysics? physics;
  
  final List<Widget>? sliversHeader;
  final List<Widget> tabViews;
  final List<Tab> tabs;
  final int initialTabIndex;
  final bool hasLeading;
  final String? title;
  final List<Widget>? actions;
  final double? toolbarHeight;


  const BuildTabBarLayout( 
      {super.key, 
      this.sliversHeader,
        this.actions,
         this.physics,
      required this.tabViews,
      required this.tabs,
      required this.initialTabIndex,
      required this.hasLeading,
      required this.toolbarHeight,
      required this.title,
      });
  

  @override
  ConsumerState<BuildTabBarLayout> createState() => _TabbedLayoutState();
}

class _TabbedLayoutState extends ConsumerState<BuildTabBarLayout>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final PageController _pageController;
   final List<ScrollController> _scrollControllers = []; // One per tab
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this, // Uses TickerProviderStateMixin
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
     // Reset scroll position of the new tab's content
      // Use WidgetsBinding.instance.addPostFrameCallback to ensure the ScrollController is attached
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollControllers[index].hasClients) {
           // Calculate the offset
        
         

          _scrollControllers[index].jumpTo(0); // Adjust the jumpTo offset
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
    final theme= ref.watch(themeDataProvider);
    final responsive = ref.watch(responsiveProvider);
    return NestedScrollView(
      physics: widget.physics ?? const ClampingScrollPhysics(),
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
           SliverOverlapAbsorber(
             handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
             sliver: CustomSliverAppBar(
              toolbarHeight: widget.toolbarHeight ?? responsive.h(50),
              hasLeading: widget.hasLeading,
              title: CustomAutoSizeText(
                text: widget.title ?? '',
                style: theme.textTheme.bodyLarge,
                // colorText: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 14,),
              actions: widget.actions,
              
             
              bottom: PreferredSize(
                preferredSize:  Size.zero, 
                child:Padding(
                  padding: responsive.paddingSym(h: 16, v: 11),
                  child: Container(
                    height: responsive.h(48),
                  
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
                )
                ),
                      
                       ),
           ),
          
          if (widget.sliversHeader != null) ...widget.sliversHeader!,
          
        ];
      },
      body: PageView(
        
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: _onPageChanged,
        children: widget.tabViews.map((tabView) => _buildTabContent(_tabController.index,widget.toolbarHeight, tabView)).toList(),
      ),
    );
  }
  Widget _buildTabContent(int tabIndex, double? topPadding, Widget tabView) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: topPadding ?? 0),

      controller: _scrollControllers[tabIndex],
      child: tabView ,
    );
    


  }

}
