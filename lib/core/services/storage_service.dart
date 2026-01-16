import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class StorageService {
  static const String _ENCRYPTION_KEY_NAME = 'hive_encryption_key';
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
}
