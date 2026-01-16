import 'package:flutter_test/flutter_test.dart';
import 'package:civil_prep_app/models/household_profile_model.dart';

void main() {
  group('HouseholdProfileModel Tests', () {
    late HouseholdProfile testProfile;
    late Map<String, dynamic> testProfileJson;

    setUp(() {
      testProfile = HouseholdProfile(
        id: 'profile-uuid-123',
        userId: 'user-uuid-456',
        postalCode: '12345',
        adultCount: 2,
        childCount: 1,
        infantCount: 0,
        housingType: HousingType.apartment,
        heatingType: HeatingType.electric,
        allowAggregation: true,
        createdAt: DateTime(2024, 1, 16, 12, 0, 0),
        updatedAt: DateTime(2024, 1, 16, 13, 0, 0),
      );

      testProfileJson = {
        'id': 'profile-uuid-123',
        'userId': 'user-uuid-456',
        'postalCode': '12345',
        'adultCount': 2,
        'childCount': 1,
        'infantCount': 0,
        'housingType': 'apartment',
        'heatingType': 'electric',
        'allowAggregation': true,
        'createdAt': '2024-01-16T12:00:00.000Z',
        'updatedAt': '2024-01-16T13:00:00.000Z',
      };
    });

    test('Should create HouseholdProfile instance with all fields', () {
      expect(testProfile.id, equals('profile-uuid-123'));
      expect(testProfile.userId, equals('user-uuid-456'));
      expect(testProfile.postalCode, equals('12345'));
      expect(testProfile.adultCount, equals(2));
      expect(testProfile.childCount, equals(1));
      expect(testProfile.infantCount, equals(0));
      expect(testProfile.housingType, equals(HousingType.apartment));
      expect(testProfile.heatingType, equals(HeatingType.electric));
      expect(testProfile.allowAggregation, isTrue);
      expect(testProfile.createdAt, equals(DateTime(2024, 1, 16, 12, 0, 0)));
      expect(testProfile.updatedAt, equals(DateTime(2024, 1, 16, 13, 0, 0)));
    });

    test('Should convert HouseholdProfile to JSON correctly', () {
      final json = testProfile.toJson();
      
      expect(json['id'], equals('profile-uuid-123'));
      expect(json['userId'], equals('user-uuid-456'));
      expect(json['postalCode'], equals('12345'));
      expect(json['adultCount'], equals(2));
      expect(json['childCount'], equals(1));
      expect(json['infantCount'], equals(0));
      expect(json['housingType'], equals('apartment'));
      expect(json['heatingType'], equals('electric'));
      expect(json['allowAggregation'], isTrue);
      expect(json['createdAt'], isA<String>());
      expect(json['updatedAt'], isA<String>());
    });

    test('Should create HouseholdProfile from JSON correctly', () {
      final profileFromJson = HouseholdProfile.fromJson(testProfileJson);
      
      expect(profileFromJson.id, equals(testProfile.id));
      expect(profileFromJson.userId, equals(testProfile.userId));
      expect(profileFromJson.postalCode, equals(testProfile.postalCode));
      expect(profileFromJson.adultCount, equals(testProfile.adultCount));
      expect(profileFromJson.childCount, equals(testProfile.childCount));
      expect(profileFromJson.infantCount, equals(testProfile.infantCount));
      expect(profileFromJson.housingType, equals(testProfile.housingType));
      expect(profileFromJson.heatingType, equals(testProfile.heatingType));
      expect(profileFromJson.allowAggregation, equals(testProfile.allowAggregation));
      expect(profileFromJson.createdAt, isA<DateTime>());
      expect(profileFromJson.updatedAt, isA<DateTime>());
    });

    test('Should verify all fields match between original and JSON-converted HouseholdProfile', () {
      final profileFromJson = HouseholdProfile.fromJson(testProfile.toJson());
      
      expect(profileFromJson.id, equals(testProfile.id));
      expect(profileFromJson.userId, equals(testProfile.userId));
      expect(profileFromJson.postalCode, equals(testProfile.postalCode));
      expect(profileFromJson.adultCount, equals(testProfile.adultCount));
      expect(profileFromJson.childCount, equals(testProfile.childCount));
      expect(profileFromJson.infantCount, equals(testProfile.infantCount));
      expect(profileFromJson.housingType, equals(testProfile.housingType));
      expect(profileFromJson.heatingType, equals(testProfile.heatingType));
      expect(profileFromJson.allowAggregation, equals(testProfile.allowAggregation));
      expect(profileFromJson.createdAt, equals(testProfile.createdAt));
      expect(profileFromJson.updatedAt, equals(testProfile.updatedAt));
    });

    test('Should create household profile using factory method', () {
      final newProfile = HouseholdProfile.create(
        userId: 'user-uuid-789',
        postalCode: '98765',
        housingType: HousingType.house,
        heatingType: HeatingType.wood,
        adultCount: 3,
        childCount: 2,
        infantCount: 1,
        allowAggregation: false,
      );
      
      expect(newProfile.id, isNotEmpty);
      expect(newProfile.userId, equals('user-uuid-789'));
      expect(newProfile.postalCode, equals('98765'));
      expect(newProfile.adultCount, equals(3));
      expect(newProfile.childCount, equals(2));
      expect(newProfile.infantCount, equals(1));
      expect(newProfile.housingType, equals(HousingType.house));
      expect(newProfile.heatingType, equals(HeatingType.wood));
      expect(newProfile.allowAggregation, isFalse);
      expect(newProfile.createdAt, isA<DateTime>());
      expect(newProfile.updatedAt, isA<DateTime>());
      expect(newProfile.createdAt, equals(newProfile.updatedAt));
    });

    test('Should update household profile using factory method', () {
      final updatedProfile = HouseholdProfile.update(
        existing: testProfile,
        postalCode: '54321',
        adultCount: 4,
        childCount: 0,
        heatingType: HeatingType.district,
        allowAggregation: false,
      );
      
      expect(updatedProfile.id, equals(testProfile.id));
      expect(updatedProfile.userId, equals(testProfile.userId));
      expect(updatedProfile.postalCode, equals('54321'));
      expect(updatedProfile.adultCount, equals(4));
      expect(updatedProfile.childCount, equals(0));
      expect(updatedProfile.infantCount, equals(testProfile.infantCount));
      expect(updatedProfile.housingType, equals(testProfile.housingType));
      expect(updatedProfile.heatingType, equals(HeatingType.district));
      expect(updatedProfile.allowAggregation, isFalse);
      expect(updatedProfile.createdAt, equals(testProfile.createdAt));
      expect(updatedProfile.updatedAt, isNot(equals(testProfile.updatedAt)));
    });

    test('Should handle copyWith correctly', () {
      final updatedProfile = testProfile.copyWith(
        postalCode: '11111',
        adultCount: 5,
        allowAggregation: false,
      );
      
      expect(updatedProfile.id, equals(testProfile.id));
      expect(updatedProfile.userId, equals(testProfile.userId));
      expect(updatedProfile.postalCode, equals('11111'));
      expect(updatedProfile.adultCount, equals(5));
      expect(updatedProfile.childCount, equals(testProfile.childCount));
      expect(updatedProfile.infantCount, equals(testProfile.infantCount));
      expect(updatedProfile.housingType, equals(testProfile.housingType));
      expect(updatedProfile.heatingType, equals(testProfile.heatingType));
      expect(updatedProfile.allowAggregation, isFalse);
      expect(updatedProfile.createdAt, equals(testProfile.createdAt));
      expect(updatedProfile.updatedAt, equals(testProfile.updatedAt));
    });

    test('Should handle enum serialization correctly', () {
      // Test all housing types
      for (final housingType in HousingType.values) {
        final profile = testProfile.copyWith(housingType: housingType);
        final json = profile.toJson();
        final profileFromJson = HouseholdProfile.fromJson(json);
        
        expect(profileFromJson.housingType, equals(housingType));
      }

      // Test all heating types
      for (final heatingType in HeatingType.values) {
        final profile = testProfile.copyWith(heatingType: heatingType);
        final json = profile.toJson();
        final profileFromJson = HouseholdProfile.fromJson(json);
        
        expect(profileFromJson.heatingType, equals(heatingType));
      }
    });

    test('Should handle default values correctly', () {
      final minimalJson = {
        'id': 'profile-uuid-minimal',
        'userId': 'user-uuid-minimal',
        'postalCode': '22222',
        'housingType': 'apartment',
        'heatingType': 'electric',
        'createdAt': '2024-01-16T12:00:00.000Z',
        'updatedAt': '2024-01-16T12:00:00.000Z',
      };
      
      final profileFromJson = HouseholdProfile.fromJson(minimalJson);
      
      expect(profileFromJson.adultCount, equals(1)); // Default value
      expect(profileFromJson.childCount, equals(0)); // Default value
      expect(profileFromJson.infantCount, equals(0)); // Default value
      expect(profileFromJson.allowAggregation, isFalse); // Default value
    });

    test('Should validate postal code format', () {
      // Test valid postal codes
      final validPostalCodes = ['12345', '98765', '11111', '99999'];
      for (final postalCode in validPostalCodes) {
        final profile = testProfile.copyWith(postalCode: postalCode);
        expect(profile.postalCode, equals(postalCode));
      }
    });

    test('Should handle minimum count requirements', () {
      // Test minimum adult count
      final profileWithMinAdults = HouseholdProfile.create(
        userId: 'test-user',
        postalCode: '12345',
        housingType: HousingType.apartment,
        heatingType: HeatingType.electric,
        adultCount: 1, // Minimum allowed
      );
      expect(profileWithMinAdults.adultCount, equals(1));

      // Test minimum child and infant counts
      final profileWithMinChildren = HouseholdProfile.create(
        userId: 'test-user',
        postalCode: '12345',
        housingType: HousingType.apartment,
        heatingType: HeatingType.electric,
        childCount: 0, // Minimum allowed
        infantCount: 0, // Minimum allowed
      );
      expect(profileWithMinChildren.childCount, equals(0));
      expect(profileWithMinChildren.infantCount, equals(0));
    });
  });
}
