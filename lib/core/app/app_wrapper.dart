import 'package:bookkeeping_flutter_app/core/app/app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      // child: DevicePreview(
      //   enabled: true,
       
      //   builder: (context) => const BookkeepingApp(),
      // ),
      child: const BookkeepingApp(),
    );
  }
}