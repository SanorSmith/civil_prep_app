import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../models/user_model.dart';
import '../../models/household_profile_model.dart';

class StorageService {
  static const String _ENCRYPTION_KEY_NAME = 'hive_encryption_key';
  static const String _USER_PROFILE_KEY = 'user_profile';
  static const String _HOUSEHOLD_PROFILE_KEY = 'household_profile';
  static const String _LANGUAGE_KEY = 'app_language';
  static const String _THEME_MODE_KEY = 'theme_mode';
  static const _secureStorage = FlutterSecureStorage();
  
  static late Box<dynamic> _settingsBox;
  static late Box<dynamic> _cacheBox;
  static late Box<dynamic> _userDataBox;

  static Future<void> initialize() async {
    final encryptionKey = await _getOrCreateEncryptionKey();
    
    _settingsBox = await Hive.openBox(
      'settings',
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
    
    _cacheBox = await Hive.openBox('cache');
    
    _userDataBox = await Hive.openBox(
      'user_data',
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
  }

  static Future<List<int>> _getOrCreateEncryptionKey() async {
    String? keyString = await _secureStorage.read(key: _ENCRYPTION_KEY_NAME);
    
    if (keyString == null) {
      final key = Hive.generateSecureKey();
      keyString = key.join(',');
      await _secureStorage.write(key: _ENCRYPTION_KEY_NAME, value: keyString);
      return key;
    }
    
    return keyString.split(',').map((e) => int.parse(e)).toList();
  }

  static Box<dynamic> get settings => _settingsBox;
  static Box<dynamic> get cache => _cacheBox;
  static Box<dynamic> get userData => _userDataBox;

  static Future<void> clearCache() async {
    await _cacheBox.clear();
  }

  static Future<void> clearAllData() async {
    await _settingsBox.clear();
    await _cacheBox.clear();
    await _userDataBox.clear();
  }

  // SharedPreferences methods for User profile (avoids Hive adapter issues)
  static Future<void> saveUserProfile(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(user.toJson());
    await prefs.setString(_USER_PROFILE_KEY, jsonString);
  }

  static Future<User?> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_USER_PROFILE_KEY);
    if (jsonString == null) return null;
    final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
    return User.fromJson(jsonMap);
  }

  static Future<void> deleteUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_USER_PROFILE_KEY);
  }

  // SharedPreferences methods for HouseholdProfile
  static Future<void> saveHouseholdProfile(HouseholdProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(profile.toJson());
    await prefs.setString(_HOUSEHOLD_PROFILE_KEY, jsonString);
  }

  static Future<HouseholdProfile?> getHouseholdProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_HOUSEHOLD_PROFILE_KEY);
    if (jsonString == null) return null;
    final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
    return HouseholdProfile.fromJson(jsonMap);
  }

  static Future<void> deleteHouseholdProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_HOUSEHOLD_PROFILE_KEY);
  }

  // Language preference
  static Future<void> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_LANGUAGE_KEY, languageCode);
  }

  static Future<String?> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LANGUAGE_KEY);
  }

  // Theme mode preference
  static Future<void> saveThemeMode(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_THEME_MODE_KEY, themeMode);
  }

  static Future<String?> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_THEME_MODE_KEY);
  }
}
