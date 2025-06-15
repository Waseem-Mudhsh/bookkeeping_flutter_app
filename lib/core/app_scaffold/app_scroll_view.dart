// import 'package:bookkeeping_flutter_app/core/providers/settings_provider.dart';

// import 'package:flutter/material.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class AppScrollView extends ConsumerWidget {
//   final Widget? floatingActionButton;
//   final Widget? drawer;
//   final Widget? bottomNavigationBar;
//   final Widget? bottomSheet;
  
//   final Widget? child;


//   const AppScrollView({
//     super.key,
//     this.floatingActionButton,
//     this.drawer,
//     this.bottomNavigationBar,
//     this.bottomSheet,
    
//     required this.child,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final settings = ref.watch(settingsProvider);
//     final isDirectionRTL = settings['isRTL'] ?? true; // Default to true for RTL
//     return Directionality(
//       textDirection: isDirectionRTL ? TextDirection.rtl : TextDirection.ltr,

//       child: Scaffold(
//         drawer: drawer,
//         floatingActionButton: floatingActionButton,
//         bottomNavigationBar: bottomNavigationBar,
//         bottomSheet: bottomSheet,
//         body: child,
//       ),
//     );
//   }
// }
