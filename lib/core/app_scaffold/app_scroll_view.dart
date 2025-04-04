import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/direction_layout_state.dart';

class AppScrollView extends ConsumerWidget {
  final List<Widget> slivers;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final ScrollPhysics? physics;

  const AppScrollView({
    super.key,
    required this.slivers,

    this.floatingActionButton,
    this.drawer,
    
    this.physics,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final isDirectionRTL = ref.watch(directionLayoutProvider);
    return Directionality( 
      textDirection: isDirectionRTL ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        drawer: drawer,
        floatingActionButton: floatingActionButton,
        body: CustomScrollView(
          physics: physics ?? const BouncingScrollPhysics(),
          slivers: [
            const SliverPadding(
              padding: EdgeInsets.only(top: kToolbarHeight ),
            ),
            ...slivers,
            const SliverSafeArea(sliver: SliverToBoxAdapter()),
          ],
        ),
      ),
    );
  }
}