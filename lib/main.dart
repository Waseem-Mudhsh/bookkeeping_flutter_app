// import 'views/home_scrren.dart';
// import 'package:bookkeeping_flutter_app/views/home_scrren.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_preview/device_preview.dart';
import 'utils/theme.dart';
import 'viewmodels/transaction_viewmodel.dart';
import 'widgets/app_bar_widget.dart';
// import 'views/home_view.dart'; // Import TransactionViewModel
// import 'views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // bool isDarkMode = prefs.getBool('isDarkMode') ?? false;

  runApp(
    DevicePreview(
      enabled: true, // Enable or disable device preview
      tools: const [
        ...DevicePreview.defaultTools,
      ],
       
      builder: (context) => MultiProvider(
        providers: [
          // ChangeNotifierProvider(create: (_) => ThemeProvider(isDarkMode)),
          ChangeNotifierProvider(create: (_) => TransactionViewModel()), // Provide TransactionViewModel
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookkeeping App',
      // theme: Provider.of<ThemeProvider>(context).getTheme(),
      theme: AppTheme.lightTheme,
      home: AppBarWidget(),
      debugShowCheckedModeBanner: false,
    
      // ignore: deprecated_member_use
      useInheritedMediaQuery: true, // Required for device_preview
      locale: DevicePreview.locale(context), // Required for device_preview
      builder: DevicePreview.appBuilder, // Required for device_preview
    );
  }
}

// class ThemeProvider with ChangeNotifier {
//   ThemeData _themeData;

//   ThemeProvider(bool isDarkMode) : _themeData = isDarkMode ? darkTheme : lightTheme;

//   ThemeData getTheme() => _themeData;

//   void setDarkMode(bool isDarkMode) {
//     _themeData = isDarkMode ? darkTheme : lightTheme;
//     notifyListeners();
//   }
// }