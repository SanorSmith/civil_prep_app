import 'package:flutter_test/flutter_test.dart';
import 'package:civil_prep_app/models/prep_category_model.dart';

void main() {
  group('PrepCategoryModel Tests', () {
    late PrepCategory testCategory;
    late Map<String, dynamic> testCategoryJson;

    setUp(() {
      testCategory = PrepCategory(
        id: 'water',
        name: 'Water',
        icon: 'water_drop',
        priority: 1,
        msbGuideline: 'https://www.msb.se/sv/amnesomraden/krisberedskap--civilt-forsvar/krisberedskap/checklista-for-hushall/',
      );

      testCategoryJson = {
        'id': 'water',
        'name': 'Water',
        'icon': 'water_drop',
        'priority': 1,
        'msbGuideline': 'https://www.msb.se/sv/amnesomraden/krisberedskap--civilt-forsvar/krisberedskap/checklista-for-hushall/',
      };
    });

    test('Should create PrepCategory instance with all fields', () {
      expect(testCategory.id, equals('water'));
      expect(testCategory.name, equals('Water'));
      expect(testCategory.icon, equals('water_drop'));
      expect(testCategory.priority, equals(1));
      expect(testCategory.msbGuideline, contains('msb.se'));
    });

    test('Should convert PrepCategory to JSON correctly', () {
      final json = testCategory.toJson();
      
      expect(json['id'], equals('water'));
      expect(json['name'], equals('Water'));
      expect(json['icon'], equals('water_drop'));
      expect(json['priority'], equals(1));
      expect(json['msbGuideline'], isA<String>());
    });

    test('Should create PrepCategory from JSON correctly', () {
      final categoryFromJson = PrepCategory.fromJson(testCategoryJson);
      
      expect(categoryFromJson.id, equals(testCategory.id));
      expect(categoryFromJson.name, equals(testCategory.name));
      expect(categoryFromJson.icon, equals(testCategory.icon));
      expect(categoryFromJson.priority, equals(testCategory.priority));
      expect(categoryFromJson.msbGuideline, equals(testCategory.msbGuideline));
    });

    test('Should verify all fields match between original and JSON-converted PrepCategory', () {
      final categoryFromJson = PrepCategory.fromJson(testCategory.toJson());
      
      expect(categoryFromJson.id, equals(testCategory.id));
      expect(categoryFromJson.name, equals(testCategory.name));
      expect(categoryFromJson.icon, equals(testCategory.icon));
      expect(categoryFromJson.priority, equals(testCategory.priority));
      expect(categoryFromJson.msbGuideline, equals(testCategory.msbGuideline));
    });

    test('Should create category using factory method', () {
      final newCategory = PrepCategory.create(
        id: 'custom',
        name: 'Custom Category',
        icon: 'star',
        priority: 99,
        msbGuideline: 'https://example.com',
      );
      
      expect(newCategory.id, equals('custom'));
      expect(newCategory.name, equals('Custom Category'));
      expect(newCategory.icon, equals('star'));
      expect(newCategory.priority, equals(99));
      expect(newCategory.msbGuideline, equals('https://example.com'));
    });

    test('Should create predefined water category', () {
      final water = PrepCategory.water();
      
      expect(water.id, equals('water'));
      expect(water.name, equals('Water'));
      expect(water.icon, equals('water_drop'));
      expect(water.priority, equals(1));
      expect(water.msbGuideline, contains('msb.se'));
    });

    test('Should create predefined food category', () {
      final food = PrepCategory.food();
      
      expect(food.id, equals('food'));
      expect(food.name, equals('Food'));
      expect(food.icon, equals('restaurant'));
      expect(food.priority, equals(2));
    });

    test('Should create predefined heating category', () {
      final heating = PrepCategory.heating();
      
      expect(heating.id, equals('heating'));
      expect(heating.name, equals('Heating'));
      expect(heating.icon, equals('local_fire_department'));
      expect(heating.priority, equals(3));
    });

    test('Should create predefined hygiene category', () {
      final hygiene = PrepCategory.hygiene();
      
      expect(hygiene.id, equals('hygiene'));
      expect(hygiene.name, equals('Hygiene'));
      expect(hygiene.icon, equals('clean_hands'));
      expect(hygiene.priority, equals(4));
    });

    test('Should create predefined communication category', () {
      final communication = PrepCategory.communication();
      
      expect(communication.id, equals('communication'));
      expect(communication.name, equals('Communication'));
      expect(communication.icon, equals('phone'));
      expect(communication.priority, equals(5));
    });

    test('Should create predefined first aid category', () {
      final firstAid = PrepCategory.firstAid();
      
      expect(firstAid.id, equals('first_aid'));
      expect(firstAid.name, equals('First Aid'));
      expect(firstAid.icon, equals('medical_services'));
      expect(firstAid.priority, equals(6));
    });

    test('Should create predefined lighting category', () {
      final lighting = PrepCategory.lighting();
      
      expect(lighting.id, equals('lighting'));
      expect(lighting.name, equals('Lighting'));
      expect(lighting.icon, equals('lightbulb'));
      expect(lighting.priority, equals(7));
    });

    test('Should create predefined documents category', () {
      final documents = PrepCategory.documents();
      
      expect(documents.id, equals('documents'));
      expect(documents.name, equals('Important Documents'));
      expect(documents.icon, equals('description'));
      expect(documents.priority, equals(8));
    });

    test('Should create predefined cash category', () {
      final cash = PrepCategory.cash();
      
      expect(cash.id, equals('cash'));
      expect(cash.name, equals('Cash'));
      expect(cash.icon, equals('payments'));
      expect(cash.priority, equals(9));
    });

    test('Should create predefined other category', () {
      final other = PrepCategory.other();
      
      expect(other.id, equals('other'));
      expect(other.name, equals('Other'));
      expect(other.icon, equals('more_horiz'));
      expect(other.priority, equals(10));
    });

    test('Should get all predefined categories', () {
      final allCategories = PrepCategory.getAllCategories();
      
      expect(allCategories, isA<List<PrepCategory>>());
      expect(allCategories.length, equals(10));
      
      // Verify all categories are present
      final ids = allCategories.map((c) => c.id).toList();
      expect(ids, contains('water'));
      expect(ids, contains('food'));
      expect(ids, contains('heating'));
      expect(ids, contains('hygiene'));
      expect(ids, contains('communication'));
      expect(ids, contains('first_aid'));
      expect(ids, contains('lighting'));
      expect(ids, contains('documents'));
      expect(ids, contains('cash'));
      expect(ids, contains('other'));
    });

    test('Should have categories sorted by priority', () {
      final allCategories = PrepCategory.getAllCategories();
      
      // Verify priorities are in ascending order
      for (int i = 0; i < allCategories.length; i++) {
        expect(allCategories[i].priority, equals(i + 1));
      }
    });

    test('Should handle copyWith correctly', () {
      final updatedCategory = testCategory.copyWith(
        name: 'Updated Water',
        priority: 99,
      );
      
      expect(updatedCategory.id, equals(testCategory.id));
      expect(updatedCategory.name, equals('Updated Water'));
      expect(updatedCategory.icon, equals(testCategory.icon));
      expect(updatedCategory.priority, equals(99));
      expect(updatedCategory.msbGuideline, equals(testCategory.msbGuideline));
    });

    test('Should serialize and deserialize all predefined categories', () {
      final allCategories = PrepCategory.getAllCategories();
      
      for (final category in allCategories) {
        final json = category.toJson();
        final categoryFromJson = PrepCategory.fromJson(json);
        
        expect(categoryFromJson.id, equals(category.id));
        expect(categoryFromJson.name, equals(category.name));
        expect(categoryFromJson.icon, equals(category.icon));
        expect(categoryFromJson.priority, equals(category.priority));
        expect(categoryFromJson.msbGuideline, equals(category.msbGuideline));
      }
    });

    test('Should have unique IDs for all categories', () {
      final allCategories = PrepCategory.getAllCategories();
      final ids = allCategories.map((c) => c.id).toSet();
      
      expect(ids.length, equals(allCategories.length));
    });

    test('Should have unique priorities for all categories', () {
      final allCategories = PrepCategory.getAllCategories();
      final priorities = allCategories.map((c) => c.priority).toSet();
      
      expect(priorities.length, equals(allCategories.length));
    });

    test('Should have MSB guideline URLs for all categories', () {
      final allCategories = PrepCategory.getAllCategories();
      
      for (final category in allCategories) {
        expect(category.msbGuideline, isNotEmpty);
        expect(category.msbGuideline, startsWith('https://'));
        expect(category.msbGuideline, contains('msb.se'));
      }
    });

    test('Should have appropriate icons for all categories', () {
      final allCategories = PrepCategory.getAllCategories();
      
      for (final category in allCategories) {
        expect(category.icon, isNotEmpty);
        expect(category.icon, isA<String>());
      }
    });
  });
}
