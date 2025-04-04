import 'package:flutter_riverpod/flutter_riverpod.dart';

// 📌 `Notifier` لإدارة الوضع الداكن
class DarkModeNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false; // الوضع الافتراضي هو الفاتح
  }

  // 🔹 تبديل بين الوضع الداكن والفاتح
  void toggle() {
    state = !state;
  }
}

// 📌 مزود `NotifierProvider` لإدارة الوضع الداكن
final darkModeProvider = NotifierProvider<DarkModeNotifier, bool>(() => DarkModeNotifier());
