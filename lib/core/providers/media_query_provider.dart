import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MediaQueryNotifier extends StateNotifier<MediaQueryData> {
  MediaQueryNotifier() : super(const MediaQueryData(size: Size.zero));

  void updateMediaQuery(MediaQueryData newMediaQuery) {
    state = newMediaQuery;
  }
}
// Define a global provider for MediaQueryData
final mediaQueryProvider = StateNotifierProvider<MediaQueryNotifier, MediaQueryData>(
  (ref) => MediaQueryNotifier(),
);

