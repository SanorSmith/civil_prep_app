import 'package:flutter_test/flutter_test.dart';
import 'package:civil_prep_app/models/user_model.dart';

void main() {
  group('UserModel Tests', () {
    late User testUser;
    late Map<String, dynamic> testUserJson;

    setUp(() {
      testUser = User(
        id: 'test-uuid-123',
        email: 'test@example.com',
        isGuest: false,
        createdAt: DateTime(2024, 1, 16, 12, 0, 0),
        lastSyncAt: DateTime(2024, 1, 16, 13, 0, 0),
      );

      testUserJson = {
        'id': 'test-uuid-123',
        'email': 'test@example.com',
        'isGuest': false,
        'createdAt': '2024-01-16T12:00:00.000Z',
        'lastSyncAt': '2024-01-16T13:00:00.000Z',
      };
    });

    test('Should create User instance with all fields', () {
      // Test Case 1: Create a User instance
      expect(testUser.id, equals('test-uuid-123'));
      expect(testUser.email, equals('test@example.com'));
      expect(testUser.isGuest, equals(false));
      expect(testUser.createdAt, equals(DateTime(2024, 1, 16, 12, 0, 0)));
      expect(testUser.lastSyncAt, equals(DateTime(2024, 1, 16, 13, 0, 0)));
    });

    test('Should convert User to JSON correctly', () {
      // Test Case 2: Convert User to JSON
      final json = testUser.toJson();
      
      expect(json['id'], equals('test-uuid-123'));
      expect(json['email'], equals('test@example.com'));
      expect(json['isGuest'], equals(false));
      expect(json['createdAt'], isA<String>());
      expect(json['lastSyncAt'], isA<String>());
    });

    test('Should create User from JSON correctly', () {
      // Test Case 3: Create User from JSON
      final userFromJson = User.fromJson(testUserJson);
      
      expect(userFromJson.id, equals(testUser.id));
      expect(userFromJson.email, equals(testUser.email));
      expect(userFromJson.isGuest, equals(testUser.isGuest));
      expect(userFromJson.createdAt, isA<DateTime>());
      expect(userFromJson.lastSyncAt, isA<DateTime>());
    });

    test('Should verify all fields match between original and JSON-converted User', () {
      // Test Case 4: Verify all fields match
      final userFromJson = User.fromJson(testUser.toJson());
      
      expect(userFromJson.id, equals(testUser.id));
      expect(userFromJson.email, equals(testUser.email));
      expect(userFromJson.isGuest, equals(testUser.isGuest));
      expect(userFromJson.createdAt, equals(testUser.createdAt));
      expect(userFromJson.lastSyncAt, equals(testUser.lastSyncAt));
    });

    test('Should create guest user correctly', () {
      final guestUser = User.createGuest();
      
      expect(guestUser.id, isNotEmpty);
      expect(guestUser.email, isNull);
      expect(guestUser.isGuest, isTrue);
      expect(guestUser.createdAt, isA<DateTime>());
      expect(guestUser.lastSyncAt, isNull);
    });

    test('Should create registered user correctly', () {
      final registeredUser = User.createRegistered(email: 'user@example.com');
      
      expect(registeredUser.id, isNotEmpty);
      expect(registeredUser.email, equals('user@example.com'));
      expect(registeredUser.isGuest, isFalse);
      expect(registeredUser.createdAt, isA<DateTime>());
      expect(registeredUser.lastSyncAt, isNull);
    });

    test('Should handle copyWith correctly', () {
      final updatedUser = testUser.copyWith(
        email: 'updated@example.com',
        lastSyncAt: DateTime(2024, 1, 16, 14, 0, 0),
      );
      
      expect(updatedUser.id, equals(testUser.id));
      expect(updatedUser.email, equals('updated@example.com'));
      expect(updatedUser.isGuest, equals(testUser.isGuest));
      expect(updatedUser.createdAt, equals(testUser.createdAt));
      expect(updatedUser.lastSyncAt, equals(DateTime(2024, 1, 16, 14, 0, 0)));
    });

    test('Should handle nullable fields correctly', () {
      final userWithNulls = User(
        id: 'test-uuid-456',
        email: null,
        isGuest: true,
        createdAt: DateTime.now(),
        lastSyncAt: null,
      );
      
      expect(userWithNulls.email, isNull);
      expect(userWithNulls.lastSyncAt, isNull);
      
      final json = userWithNulls.toJson();
      expect(json['email'], isNull);
      expect(json['lastSyncAt'], isNull);
      
      final userFromJson = User.fromJson(json);
      expect(userFromJson.email, isNull);
      expect(userFromJson.lastSyncAt, isNull);
    });

    test('Should handle JSON with missing optional fields', () {
      final minimalJson = {
        'id': 'test-uuid-789',
        'isGuest': true,
        'createdAt': '2024-01-16T12:00:00.000Z',
      };
      
      final userFromJson = User.fromJson(minimalJson);
      
      expect(userFromJson.id, equals('test-uuid-789'));
      expect(userFromJson.email, isNull);
      expect(userFromJson.isGuest, isTrue);
      expect(userFromJson.createdAt, isA<DateTime>());
      expect(userFromJson.lastSyncAt, isNull);
    });
  });
}
