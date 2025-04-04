import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dark_mode_provider.dart';

class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final  isDarkMode  = ref.watch(darkModeProvider); // مراقبة وضع الثيم الحالي
    final  darkModeNotifier  =ref.read(darkModeProvider.notifier); // قراءة وضع الثيم الحالي من `Provider.of<ThemeProvider>(context)`
    final colorScheme = Theme.of(context).colorScheme;
    
    return Switch(
      activeColor:colorScheme.primary ,
      value: isDarkMode,
      onChanged: (value) => darkModeNotifier.toggle(),
    );
  }
}