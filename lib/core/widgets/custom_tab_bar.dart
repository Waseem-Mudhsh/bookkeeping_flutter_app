// import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';


// class CustomTabBar extends ConsumerWidget implements PreferredSizeWidget {
//   final List<Tab> tabs;
//   final TabController? tabController;
//   final bool isScrollable;
  

//   const CustomTabBar({
//      required this.tabs,
//      this.tabController,
//       this.isScrollable = false,
//      super.key
//      });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final theme = ref.theme;
//     final responsive = ref.responsive;
//     return TabBar(
//       controller: tabController,
//       isScrollable: isScrollable,
//       dividerColor: Colors.transparent,

//       tabs: tabs,
//       indicatorAnimation: TabIndicatorAnimation.elastic,
//           indicatorSize: TabBarIndicatorSize.tab,
//           indicatorPadding:  responsive.paddingSym(h: 4, v: 4),
//           // indicatorWeight: 0.5,
//           mouseCursor: MouseCursor.defer,
//           physics: const ClampingScrollPhysics(),
//           labelColor: theme.colorScheme.onPrimary,
//           unselectedLabelColor: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
//            indicator: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8.0),
//                       color: theme.colorScheme.primary,
//                       ),
//           labelStyle: theme.textTheme.bodySmall!.copyWith(
            
//             fontWeight: FontWeight.bold
//           ),
//           unselectedLabelStyle: theme.textTheme.bodySmall!.copyWith(
            
//             fontWeight: FontWeight.w500
//           ),
         
//       );
//   }
  
//   @override
  
//   Size get preferredSize => throw UnimplementedError();
  
  
// }
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTabBar extends ConsumerWidget implements PreferredSizeWidget {
  final List<Tab> tabs;
  final TabController? tabController;
  final bool isScrollable;

  const CustomTabBar({
    required this.tabs,
    this.tabController,
    this.isScrollable = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final responsive = ref.responsive;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface, // لون الخلفية
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.2), // خط فاصل خفيف
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: tabController,
        isScrollable: isScrollable,
        dividerColor: Colors.transparent,
        tabs: tabs,
        indicator: UnderlineTabIndicator( // استخدم Underline بدلاً من BoxDecoration
          borderSide: BorderSide(
            width: 3.0,
            color: theme.colorScheme.primary, // لون الخط السفلي
          ),
          insets: const EdgeInsets.fromLTRB(
              10.0, 0.0, 10.0, 4), // مساحة الخط السفلي
        ),
        indicatorSize: TabBarIndicatorSize.label, // حجم الخط السفلي
        physics: const ClampingScrollPhysics(),
        labelColor: theme.colorScheme.primary, // لون النص المحدد
        unselectedLabelColor:
            theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.8), // لون النص غير المحدد
        labelStyle: theme.textTheme.bodyMedium!.copyWith( // خط النص المحدد
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: theme.textTheme.bodyMedium!.copyWith( // خط النص غير المحدد
          fontWeight: FontWeight.normal,
        ),
        splashFactory: NoSplash.splashFactory, // منع تأثير النقر
        overlayColor: WidgetStateProperty.all(Colors.transparent), // منع تأثير التحديد
        // padding: responsive.paddingSym(h: 16, v: 8), // مساحة داخلية
      ),
    );
  }

  @override
  Size get preferredSize => throw UnimplementedError();
}