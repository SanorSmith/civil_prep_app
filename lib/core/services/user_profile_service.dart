import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserProfileService {
  static const String _keyUserProfile = 'user_profile';
  static const String _keyHeroCardDismissed = 'hero_card_dismissed';
  static const String _keyLastSaveTime = 'last_save_time';
  
  /// Get or create user profile
  Future<UserProfile> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = prefs.getString(_keyUserProfile);
    
    if (profileJson != null && profileJson.isNotEmpty) {
      try {
        final Map<String, dynamic> data = json.decode(profileJson);
        return UserProfile.fromJson(data);
      } catch (e) {
        print('Error parsing user profile: $e');
      }
    }
    
    return UserProfile(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'Användare',
      createdAt: DateTime.now(),
    );
  }
  
  /// Save user profile
  Future<void> saveUserProfile(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = json.encode(profile.toJson());
    await prefs.setString(_keyUserProfile, profileJson);
    await _updateLastSaveTime();
    
    print('✅ User profile saved: ${profile.name}');
  }
  
  /// Update user name
  Future<void> updateUserName(String name) async {
    final profile = await getUserProfile();
    final updatedProfile = profile.copyWith(name: name);
    await saveUserProfile(updatedProfile);
  }
  
  /// Check if hero card is dismissed
  Future<bool> isHeroCardDismissed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyHeroCardDismissed) ?? false;
  }
  
  /// Dismiss hero card
  Future<void> dismissHeroCard() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyHeroCardDismissed, true);
    await _updateLastSaveTime();
    
    print('✅ Hero card dismissed');
  }
  
  /// Show hero card again
  Future<void> showHeroCard() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyHeroCardDismissed, false);
    await _updateLastSaveTime();
  }
  
  /// Get last save time
  Future<DateTime?> getLastSaveTime() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt(_keyLastSaveTime);
    
    if (timestamp != null) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    return null;
  }
  
  /// Update last save time (called automatically)
  Future<void> _updateLastSaveTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyLastSaveTime, DateTime.now().millisecondsSinceEpoch);
  }
  
  /// Auto-save notification
  Future<void> triggerAutoSave(String action) async {
    await _updateLastSaveTime();
    print('💾 Auto-saved: $action at ${DateTime.now()}');
  }
}

/// User profile model
class UserProfile {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime? lastActiveAt;
  
  UserProfile({
    required this.id,
    required this.name,
    required this.createdAt,
    this.lastActiveAt,
  });
  
  UserProfile copyWith({
    String? name,
    DateTime? lastActiveAt,
  }) {
    return UserProfile(
      id: id,
      name: name ?? this.name,
      createdAt: createdAt,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'lastActiveAt': lastActiveAt?.toIso8601String(),
    };
  }
  
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastActiveAt: json['lastActiveAt'] != null 
        ? DateTime.parse(json['lastActiveAt'] as String)
        : null,
    );
  }
}
