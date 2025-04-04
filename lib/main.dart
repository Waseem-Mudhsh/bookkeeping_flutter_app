// import 'package:bookkeeping_flutter_app/Providers/device_size_notifier.dart';
// import 'package:bookkeeping_flutter_app/Providers/theme_data_provider.dart';
// import 'package:bookkeeping_flutter_app/features/Customers/presentation/screens/customers_screen.dart';
// import 'package:bookkeeping_flutter_app/models/customer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:device_preview/device_preview.dart'  ;
// import 'package:hive_flutter/adapters.dart';
// import 'Providers/dark_mode_provider.dart';


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // SharedPreferences prefs = await SharedPreferences.getInstance();
//   // bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
//  // ✅ Initialize Hive only once
//   await Hive.initFlutter();

//   // ✅ Register the adapter BEFORE opening the box
//   if (!Hive.isAdapterRegistered(0)) {
//     Hive.registerAdapter(CustomerAdapter());
//   }

//   // ✅ Open the box only once
//   await Hive.openBox<Customer>('customers');
 

//   runApp(
//     ProviderScope(
//       child: DevicePreview(
//         enabled: true, // Enable or disable device preview
//         tools: const [...DevicePreview.defaultTools],
      
//         builder: (context) => const MyApp(),
//       ),
//     ),
//   );
// }



// class MyApp extends ConsumerStatefulWidget  {
//   const MyApp({super.key});

//   @override
//   ConsumerState<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends ConsumerState<MyApp> {
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//   // Ensure the widget tree is built before modifying the provider
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final deviceSize = MediaQuery.of(context).size;
//       ref.read(deviceSizeProvider.notifier).updateSize(deviceSize);
//     });
// }

  

//   @override
//   Widget build(BuildContext context) {
    
//     final isDarkMode = ref.watch(darkModeProvider);
//     final theme = ref.watch(themeDataProvider);

//     return MaterialApp(
//       title: 'Bookkeeping App',
//       theme: theme,
//       themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
//       home:CustomersScreen(),
//       debugShowCheckedModeBanner: false,
//       // useInheritedMediaQuery: true,
//       locale: DevicePreview.locale(context),
//       builder: DevicePreview.appBuilder,
//     );
//   }
// }

import 'package:bookkeeping_flutter_app/core/app/app_wrapper.dart';
import 'package:bookkeeping_flutter_app/core/constants/hive_config.dart';
import 'package:flutter/material.dart';

void main() async {
  await _initializeApp();
  runApp(const AppWrapper());
}

Future<void> _initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.initialize();
  // await DeviceConfig.initialize();
}