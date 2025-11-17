import 'package:bookkeeping_flutter_app/core/custom_slivers/custom_sliver_app_bar.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_icon_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// قالب جاهز لواجهة تحتوي على رأس متقلص (Collapsing Header)
/// و شريط تابات (TabBar) مثبت أسفله.
///
/// هذا القالب يستخدم الطريقة المثالية في فلاتر:
/// NestedScrollView + SliverAppBar (with 'bottom' property) + TabBarView
class BuildTabBarLayout extends ConsumerStatefulWidget {
  final List<Tab> tabs;
  final List<Widget> tabViews; // المحتوى الخاص بكل تاب
  final Color? backgroundColorAppBar;

  final Widget titleWidget; // العنوان الذي يظهر عند التقلص
  final Widget? backgroundWidget; // الخلفية التي تتلاشى (داخل flexibleSpace)
  final double expandedHeight;
  final bool? hasDrawer; // الارتفاع الكامل للرأس

  final int initialTabIndex;
  final List<Widget>? actions;
  final CustomIconButton? leadingWidget;

  const BuildTabBarLayout({
    super.key,
    required this.tabs,
    required this.tabViews,
    this.backgroundColorAppBar,
    required this.titleWidget,
    this.backgroundWidget,
    this.expandedHeight = 250.0,
    this.initialTabIndex = 0,
    this.actions,
    this.hasDrawer, 
    this.leadingWidget,
  }) : // التأكد من أن عدد التابات يطابق عدد صفحات المحتوى
       assert(tabs.length == tabViews.length);

  @override
  ConsumerState<BuildTabBarLayout> createState() => _BuildTabBarLayoutState();
}

class _BuildTabBarLayoutState extends ConsumerState<BuildTabBarLayout>
    with TickerProviderStateMixin {
  late TabController _tabController;
  // قائمة متحكمات التمرير (واحد لكل صفحة تاب)
  late List<ScrollController> _scrollControllers;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTabIndex;
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: _currentIndex,
    );

    // ربط 'listener' لمراقبة تغيير التابات
    _tabController.addListener(_handleTabSelection);

    // إنشاء ScrollController لكل صفحة تاب
    _scrollControllers = List.generate(
      widget.tabs.length,
      (_) => ScrollController(),
    );
  }

  // هذه هي الدالة التي تحقق متطلبك: "يظهر محتواها من البداية"
  void _handleTabSelection() {
    // نتأكد أن التغيير حدث (وليس مجرد حركة انتقالية)
    if (_tabController.indexIsChanging) return;

    final newIndex = _tabController.index;
    if (newIndex != _currentIndex) {
      setState(() {
        _currentIndex = newIndex;
      });

      // إذا كان المستخدم قد مرر للأسفل في التاب الجديد، أعده للأعلى
      if (_scrollControllers[newIndex].hasClients &&
          _scrollControllers[newIndex].offset > 0) {
        // نستخدم 'addPostFrameCallback' لضمان أن الواجهة قد اكتمل بناؤها
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollControllers[newIndex].animateTo(
            0.0, // العودة للبداية (الأعلى)
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        });
      }
    }
  }

  @override
  void didUpdateWidget(covariant BuildTabBarLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    // معالجة تغيير عدد التابات (للحالات المتقدمة)
    if (oldWidget.tabs.length != widget.tabs.length) {
      _tabController.removeListener(_handleTabSelection);
      _tabController.dispose();
      for (var controller in _scrollControllers) {
        controller.dispose();
      }

      // إعادة تهيئة كل شيء
      _initializeControllers();
    }
  }

  // دالة تهيئة منفصلة لتجنب التكرار
  void _initializeControllers() {
    _currentIndex = (_currentIndex < widget.tabs.length) ? _currentIndex : 0;
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: _currentIndex,
    );
    _tabController.addListener(_handleTabSelection);
    _scrollControllers = List.generate(
      widget.tabs.length,
      (_) => ScrollController(),
    );
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    for (var controller in _scrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    final responsive = ref.responsive;

    // لا نحتاج لـ 'Scaffold' هنا، لأن هذا القالب سيُستخدم داخل واجهة
    // تحتوي أصلاً على 'Scaffold' (أو يمكنك إضافته إذا أردت)
    return NestedScrollView(
      // --- هذا هو الرأس المتداخل ---
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          // --- 1. الـ Absorber لحساب التداخل ---
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),

            // --- 2. الـ SliverAppBar (يقوم بكل العمل) ---
            sliver: CustomSliverAppBar(
              backgroundColor: widget.backgroundColorAppBar,
              leadingWidget: widget.leadingWidget,
              hasDrawer: widget.hasDrawer ?? false,
              title: widget.titleWidget,
              // العنوان (متطلب #2)
              pinned: true, // <-- يثبت العنوان والـ 'bottom' (متطلب #2, #4)
              floating: false, // نريده مثبتاً وليس طافياً
              snap: false,

              actions: widget.actions,
              expandedHeight: widget.expandedHeight, // الارتفاع الكامل
              // --- 3. الخلفية المتلاشية (متطلب #3) ---
              flexibleSpaceContent: FlexibleSpaceBar(
                centerTitle: true,
                collapseMode: CollapseMode.parallax,
                 

                background: widget.backgroundWidget,
              ),

              // --- 4. شريط التابات المثبت (متطلب #4) ---
              // هذا هو السر: 'bottom' يتم تثبيته تلقائياً مع 'SliverAppBar'
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: CustomTabBar(
                  tabController: _tabController,
                  tabs: widget.tabs,
                  isScrollable: true,
                ),
              ),
             
            ),
          ),
        ];
      },

      // --- 5. محتوى التابات (متطلب #5) ---
      body: Padding(
        padding:responsive.paddingOnly(
        left: responsive.w(16),
        right: responsive.w(16),
        bottom: responsive.h(8),
        top: responsive.h(8),),
        child: TabBarView(
          controller: _tabController,
          children:
              widget.tabViews.asMap().entries.map((entry) {
                final int index = entry.key;
                final Widget tabContent = entry.value;
        
                // نستخدم 'Builder' لإعطاء كل صفحة 'context' فريد
                return Builder(
                  builder: (BuildContext context) {
                    // كل صفحة تاب هي 'CustomScrollView' مستقل
                    return CustomScrollView(
                     physics: const ClampingScrollPhysics(),
                     
                      controller:
                          _scrollControllers[index], // <-- ربط الـ controller
                      key: PageStorageKey<String>(
                        widget.tabs[index].text ?? 'tab_$index',
                      ),
                      slivers: <Widget>[
                        // --- 6. الـ Injector لترك مساحة للرأس ---
                        SliverOverlapInjector(
                          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context,
                          ),
                        ),
        
                        // --- 7. المحتوى الفعلي للتاب ---
                        // نتحقق إذا كان المحتوى 'Sliver' جاهزاً أو ويدجت عادي
                        if (tabContent is SliverList ||
                            tabContent is SliverGrid ||
                            tabContent is SliverFillRemaining ||
                            tabContent is SliverToBoxAdapter)
                          tabContent
                        else
                          // 'SliverToBoxAdapter' يمنع أي 'RenderFlex overflow'
                          SliverToBoxAdapter(child: tabContent),
        
                        // --- 8. حل مشكلة (Overflow 3.9px) ---
                        // إضافة padding لـ 'SafeArea' السفلية
                        // SliverToBoxAdapter(
                        //   child: ResponsiveSpace(height: bottomPadding),
                        // ),
                      ],
                    );
                  },
                );
              }).toList(),
        ),
      ),
    );
  }
}
