import 'package:bookkeeping_flutter_app/core/providers/shared_preferences_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsNotifier extends StateNotifier<Map<String, dynamic>> {
  final Ref ref;
  
  SettingsNotifier(this.ref) : super({}) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    state = {
      'isDarkMode': prefs.getBool('isDarkMode') ?? false,
      'language': prefs.getString('language') ?? 'ar',
      'isRTL': prefs.getBool('isRTL') ?? true,
      'userName': prefs.getString('userName') ?? 'Waseem User',
      'userEmail': prefs.getString('userEmail') ?? 'was@gmail.com',
      'userPassword':prefs.getString('userPassword') ?? '123',
    };
  }
  

  Future<void> toggleDarkMode(bool value) async {
    
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setBool('isDarkMode', value);
    state = {...state, 'isDarkMode': value};
  }

  Future<void> changeLanguage(String langCode) async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setString('language', langCode);
    state = {...state, 'language': langCode};
  }
  Future<void> changeIsRTL(bool value) async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setBool('isRTL', value);
    state = {...state, 'isRTL': value};
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, Map<String, dynamic>>((ref) {
  return SettingsNotifier(ref);
});
