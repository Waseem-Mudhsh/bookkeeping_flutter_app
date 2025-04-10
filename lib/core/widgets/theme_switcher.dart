import 'package:bookkeeping_flutter_app/core/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final colorScheme = Theme.of(context).colorScheme;
       final settings = ref.watch(settingsProvider);
    final isDark = settings['isDarkMode'] ?? false;


    return Switch(
      activeColor: colorScheme.primary,
      value: isDark,
      onChanged: (value) async {
        
        await ref.read(settingsProvider.notifier).toggleDarkMode(value);
      },
    );
  }
}