import 'package:bookkeeping_flutter_app/core/providers/device_size_notifier.dart';
import 'package:bookkeeping_flutter_app/core/providers/settings_provider.dart';
import 'package:bookkeeping_flutter_app/core/providers/theme_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/Customers/presentation/screens/customers_screen.dart';

class BookkeepingApp extends ConsumerStatefulWidget {
  const BookkeepingApp({super.key});

  @override
  ConsumerState<BookkeepingApp> createState() => _BookkeepingAppState();
}

class _BookkeepingAppState extends ConsumerState<BookkeepingApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateDeviceSize();
  }

  void _updateDeviceSize() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final deviceSize = MediaQuery.of(context).size;
      ref.read(deviceSizeProvider.notifier).updateSize(deviceSize);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Initialize SharedPreferences and settings provider
    final isDark = ref.read(settingsProvider)['isDarkMode'] ?? false;

    final theme = ref.watch(themeDataProvider);

    return MaterialApp(
      title: 'Bookkeeping App',
      theme: theme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      
      home: const CustomersScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}