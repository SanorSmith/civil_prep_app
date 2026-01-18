import 'package:shared_preferences/shared_preferences.dart';

class AppStateService {
  static const String _keyLanguage = 'app_language';
  static const String _keyThemeMode = 'theme_mode';
  static const String _keyLastActiveTime = 'last_active_time';
  
  Future<void> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage, languageCode);
    await _updateLastActiveTime();
    
    print('💾 Saved language: $languageCode');
  }
  
  Future<String?> getSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguage);
  }
  
  Future<void> saveThemeMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyThemeMode, mode);
    await _updateLastActiveTime();
    
    print('💾 Saved theme: $mode');
  }
  
  Future<String?> getSavedThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyThemeMode);
  }
  
  Future<void> _updateLastActiveTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyLastActiveTime, DateTime.now().millisecondsSinceEpoch);
  }
  
  Future<DateTime?> getLastActiveTime() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt(_keyLastActiveTime);
    
    if (timestamp != null) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    return null;
  }
  
  Future<void> saveStateBeforeClose() async {
    await _updateLastActiveTime();
    print('💾 App state saved at ${DateTime.now()}');
  }
  
  Future<AppState> restoreState() async {
    final language = await getSavedLanguage();
    final theme = await getSavedThemeMode();
    final lastActive = await getLastActiveTime();
    
    print('📂 Restored state:');
    print('  Language: $language');
    print('  Theme: $theme');
    print('  Last active: $lastActive');
    
    return AppState(
      language: language ?? 'sv',
      themeMode: theme ?? 'system',
      lastActiveTime: lastActive,
    );
  }
}

class AppState {
  final String language;
  final String themeMode;
  final DateTime? lastActiveTime;
  
  AppState({
    required this.language,
    required this.themeMode,
    this.lastActiveTime,
  });
}
