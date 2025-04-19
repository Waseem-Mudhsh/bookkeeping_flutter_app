import 'package:bookkeeping_flutter_app/core/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/responsive_notifier.dart';

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
    final settings = ref.watch(settingsProvider);
    final responsive = ref.watch(responsiveProvider);

    final isDirectionRTL = settings['isRTL'] ?? true; // Default to true for RTL
    return Directionality(
      textDirection: isDirectionRTL ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        drawer: drawer,
        floatingActionButton: floatingActionButton,
        body: SafeArea(
          top: responsive.orientation == Orientation.portrait?
              true
              : false, // Adjust based on orientation
          child: CustomScrollView(
            shrinkWrap: true,
            physics: physics ?? const BouncingScrollPhysics(),
            slivers: [
             
              ...slivers,
          
              
            ],
          ),
        ),
      ),
    );
  }
}
