
import 'package:bookkeeping_flutter_app/core/providers/media_query_provider.dart';
import 'package:bookkeeping_flutter_app/core/providers/settings_provider.dart';
import 'package:bookkeeping_flutter_app/core/providers/theme_data_provider.dart';
import 'package:bookkeeping_flutter_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';




class BookkeepingApp extends ConsumerStatefulWidget {
  const BookkeepingApp({super.key});

  @override
  ConsumerState<BookkeepingApp> createState() => _BookkeepingAppState();
}

class _BookkeepingAppState extends ConsumerState<BookkeepingApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateMediaQuery();
  }

  void _updateMediaQuery() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mediaQuery = MediaQuery.of(context);
      ref.read(mediaQueryProvider.notifier).updateMediaQuery(mediaQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Initialize SharedPreferences and settings provider
    final isDark = ref.read(settingsProvider)['isDarkMode'] ?? false;
    final theme = ref.watch(themeDataProvider);

    return MaterialApp(
      locale: Locale('ar'),
  supportedLocales: [
    Locale('en'),
    Locale('ar'),
  ],
  localizationsDelegates: <LocalizationsDelegate<Object>>[
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
      title: 'Bookkeeping App',
      theme: theme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

      home : Builder(
  builder: (context) {
    FlutterError.onError = (details) {
      // Extract useful info from the stack trace
      final stackTrace = details.stack;
      final errorLocation = stackTrace != null 
          ? _parseStackTrace(stackTrace) 
          : "No stack trace available";

      // Print full error to console (for debugging)
      debugPrint("‼️ Error: ${details.exception}");
      debugPrint("📌 Location:\n$errorLocation");

      // Show dialog
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Error Occurred', style: TextStyle(color: Colors.red)),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    details.exception.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text("Where it happened:", style: TextStyle(fontSize: 12)),
                  Text(
                    errorLocation,
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(
                    text: "Error: ${details.exception}\n\nLocation:\n$errorLocation",
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied to clipboard!')),
                  );
                },
                child: const Text('Copy Error'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      });
    };
    return LoginScreen();
    // return  HomeScreen();
  },
),
     

      debugShowCheckedModeBanner: false,
    );

  }
  /// Helper function to extract the most relevant line from the stack trace
String _parseStackTrace(StackTrace stackTrace) {
  final lines = stackTrace.toString().split('\n');
  if (lines.length > 1) {
    // The first line is usually the most relevant (where the error originated)
    return lines.take(3).join('\n'); // Show top 3 lines for context
  }
  return stackTrace.toString();
}
}
