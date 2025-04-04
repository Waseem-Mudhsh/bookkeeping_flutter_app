import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/direction_layout_state.dart';

class DirectionToggleButton extends ConsumerWidget {
  const DirectionToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDirectionRTL = ref.watch(
      directionLayoutProvider,
    ); // مراقبة وضع الثيم الحالي
    final directionNotifier = ref.read(directionLayoutProvider.notifier);

    return Switch(
      value: isDirectionRTL,
      onChanged: (value) => directionNotifier.toggle(),
    );
  }
}