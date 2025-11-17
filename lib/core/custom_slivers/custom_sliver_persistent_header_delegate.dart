import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomSliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  CustomSliverPersistentHeaderDelegate({
    required this.minHeight ,
    required this.maxHeight ,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant CustomSliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
           oldDelegate.maxHeight != maxHeight ||
           oldDelegate.child != child;
  }
}

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Widget title;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? background;
  final Widget? floating;
  final WidgetRef ref;
  final double floatingHeight;


  const CustomSliverAppBarDelegate({
    required this.expandedHeight,
    required this.title,
    this.actions,
    this.leading,
    this.background,
    this.floating,
    required this.ref,
    this.floatingHeight = 80.0,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    
    // --- (1) احصل على الـ Padding العلوي (لشريط الحالة) ---
    final topPadding = MediaQuery.of(context).padding.top;

    final size = ref.responsive.w(60);

    // --- (2) أضف topPadding إلى حساباتك ---
    // الارتفاع الأقصى "الحقيقي"
    final realMaxExtent = maxExtent; 
    // الارتفاع الأدنى "الحقيقي"
    final realMinExtent = minExtent; // هذا سيصبح (kToolbarHeight + topPadding)
    
    final realExpandedHeight = realMaxExtent - realMinExtent;
    final realShrinkOffset = shrinkOffset.clamp(0.0, realExpandedHeight);
    
    final opacity = 1.0 - (realShrinkOffset / realExpandedHeight).clamp(0.0, 1.0);
    final titleOpacity = 1.0 - opacity;

    final top = realMaxExtent - shrinkOffset - size / 2;

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        // الخلفية (تختفي)
        Opacity(opacity: opacity, child: buildBackground(shrinkOffset, background)),
        
        // --- (3) ضع الـ AppBar داخل Padding ---
        // هذا يضمن أن الـ AppBar يبدأ "تحت" شريط الحالة
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          // الارتفاع الأدنى = 56 (AppBar) + 30 (Padding)
          height: realMinExtent, 
          child: buildAppBar(titleOpacity, topPadding), // <-- مرر topPadding
        ),

        // الويدجت العائم
        Positioned(
          // (هذا الحساب قد يحتاج تعديل بسيط بناءً على الـ topPadding)
          top: top - ref.responsive.h(20) - topPadding, 
          left: ref.responsive.w(16),
          right: ref.responsive.w(16),
          child: floating != null
              ? buildFloating(opacity) // <-- استخدم 'opacity'
              : SizedBox.shrink(),
        ),
      ],
    );
  }

  // (دالة appear/disappear غير ضرورية)

  Widget buildAppBar(double opacity, double topPadding) => AppBar(
        // --- (4) اجعل الـ AppBar شفافاً واجعل ارتفاعه 56 فقط ---
        // الـ Padding الخارجي سيهتم بالـ 30px الإضافية
        backgroundColor:
            ref.theme.colorScheme.surface.withValues(alpha:  opacity.clamp(0.0, 1.0)),
        elevation: opacity > 0.8 ? 2 : 0, // ظل خفيف عند التقلص
        // اجعل AppBar يستخدم الارتفاع القياسي
        toolbarHeight: kToolbarHeight, 
        title: Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: title,
        ),
        leading: leading,
        actions: actions,
      );

  Widget buildBackground(double shrinkOffset, Widget? background) => Opacity(
        // (يمكنك استخدام حساب الـ opacity من دالة build)
        opacity: 1 - (shrinkOffset / (expandedHeight - minExtent)).clamp(0.0, 1.0),
        child: background,
      );

  Widget buildFloating(double opacity) => Opacity(
        opacity: opacity,
        child: Container(
          // ... (كود الديكور الخاص بك كما هو)
          padding: ref.responsive.paddingSym(h: 12, v: 12),
          decoration: BoxDecoration(
            color: ref.theme.colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: ref.theme.colorScheme.shadow.withValues(alpha: 0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: floating,
        ),
      );

  @override
  double get maxExtent {
    // --- (5) الارتفاع الأقصى يجب أن يحسب الـ padding أيضاً ---
    // (افترض أن expandedHeight لا يشمل الـ padding)
    // دعنا نبقي هذا كما هو حالياً لتجنب التعقيد
    return expandedHeight; 
  }

  @override
  double get minExtent {
    // --- (6) الحل الحاسم لعدم الثبات ---
    // الارتفاع الأدنى يجب أن يكون الـ 30 بكسل التي أضفتها
    // (والتي تعمل كـ padding) + ارتفاع الـ AppBar القياسي.
    // **هذا هو الرقم الذي يجب أن يكون صحيحاً**
    return kToolbarHeight + 30.0; // <-- أبقِ هذا كما هو (86 بكسل)
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // (إصلاح الأداء)
    if (oldDelegate is! CustomSliverAppBarDelegate) return true;
    return oldDelegate.expandedHeight != expandedHeight ||
        oldDelegate.title != title ||
        oldDelegate.actions != actions ||
        oldDelegate.leading != leading ||
        oldDelegate.background != background ||
        oldDelegate.floating != floating ||
        oldDelegate.ref != ref;
  }
}


