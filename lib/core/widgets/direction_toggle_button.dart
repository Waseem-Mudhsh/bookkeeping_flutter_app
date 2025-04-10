import 'package:bookkeeping_flutter_app/core/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DirectionToggleButton extends ConsumerWidget {
  const DirectionToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final isDirectionRTL = settings['isRTL'] ?? true; // Default to true for RTL isDark = settings['isDarkMode'] ?? false;

    return Switch(
      value: isDirectionRTL,
      onChanged: (value) async {
        await ref.read(settingsProvider.notifier).changeIsRTL(value);
      },
    );
  }
}