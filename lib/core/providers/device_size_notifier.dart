import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a StateNotifier to manage device size
class DeviceSizeNotifier extends StateNotifier<Size> {
  DeviceSizeNotifier() : super(const Size(0, 0));

  void updateSize(Size newSize) {
    state = newSize;
  }
}

// Define a global provider for device size
final deviceSizeProvider = StateNotifierProvider<DeviceSizeNotifier, Size>(
  (ref) => DeviceSizeNotifier(),
);


