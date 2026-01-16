import 'package:flutter_test/flutter_test.dart';
import 'package:civil_prep_app/models/prep_item_model.dart';

void main() {
  group('PrepItemModel Tests', () {
    late PrepItem testItem;
    late Map<String, dynamic> testItemJson;

    setUp(() {
      testItem = PrepItem(
        id: 'item-uuid-123',
        userId: 'user-uuid-456',
        categoryId: 'category-uuid-789',
        name: 'Drinking Water',
        targetQuantity: 30.0,
        currentQuantity: 15.0,
        unit: 'liters',
        isCompleted: false,
        completedAt: null,
        isCustom: false,
        syncVersion: 1,
        createdAt: DateTime(2024, 1, 16, 12, 0, 0),
        updatedAt: DateTime(2024, 1, 16, 13, 0, 0),
      );

      testItemJson = {
        'id': 'item-uuid-123',
        'userId': 'user-uuid-456',
        'categoryId': 'category-uuid-789',
        'name': 'Drinking Water',
        'targetQuantity': 30.0,
        'currentQuantity': 15.0,
        'unit': 'liters',
        'isCompleted': false,
        'completedAt': null,
        'isCustom': false,
        'syncVersion': 1,
        'createdAt': '2024-01-16T12:00:00.000Z',
        'updatedAt': '2024-01-16T13:00:00.000Z',
      };
    });

    test('Should create PrepItem instance with all fields', () {
      expect(testItem.id, equals('item-uuid-123'));
      expect(testItem.userId, equals('user-uuid-456'));
      expect(testItem.categoryId, equals('category-uuid-789'));
      expect(testItem.name, equals('Drinking Water'));
      expect(testItem.targetQuantity, equals(30.0));
      expect(testItem.currentQuantity, equals(15.0));
      expect(testItem.unit, equals('liters'));
      expect(testItem.isCompleted, isFalse);
      expect(testItem.completedAt, isNull);
      expect(testItem.isCustom, isFalse);
      expect(testItem.syncVersion, equals(1));
      expect(testItem.createdAt, equals(DateTime(2024, 1, 16, 12, 0, 0)));
      expect(testItem.updatedAt, equals(DateTime(2024, 1, 16, 13, 0, 0)));
    });

    test('Should convert PrepItem to JSON correctly', () {
      final json = testItem.toJson();
      
      expect(json['id'], equals('item-uuid-123'));
      expect(json['userId'], equals('user-uuid-456'));
      expect(json['categoryId'], equals('category-uuid-789'));
      expect(json['name'], equals('Drinking Water'));
      expect(json['targetQuantity'], equals(30.0));
      expect(json['currentQuantity'], equals(15.0));
      expect(json['unit'], equals('liters'));
      expect(json['isCompleted'], isFalse);
      expect(json['completedAt'], isNull);
      expect(json['isCustom'], isFalse);
      expect(json['syncVersion'], equals(1));
      expect(json['createdAt'], isA<String>());
      expect(json['updatedAt'], isA<String>());
    });

    test('Should create PrepItem from JSON correctly', () {
      final itemFromJson = PrepItem.fromJson(testItemJson);
      
      expect(itemFromJson.id, equals(testItem.id));
      expect(itemFromJson.userId, equals(testItem.userId));
      expect(itemFromJson.categoryId, equals(testItem.categoryId));
      expect(itemFromJson.name, equals(testItem.name));
      expect(itemFromJson.targetQuantity, equals(testItem.targetQuantity));
      expect(itemFromJson.currentQuantity, equals(testItem.currentQuantity));
      expect(itemFromJson.unit, equals(testItem.unit));
      expect(itemFromJson.isCompleted, equals(testItem.isCompleted));
      expect(itemFromJson.completedAt, equals(testItem.completedAt));
      expect(itemFromJson.isCustom, equals(testItem.isCustom));
      expect(itemFromJson.syncVersion, equals(testItem.syncVersion));
      expect(itemFromJson.createdAt, isA<DateTime>());
      expect(itemFromJson.updatedAt, isA<DateTime>());
    });

    test('Should verify all fields match between original and JSON-converted PrepItem', () {
      final itemFromJson = PrepItem.fromJson(testItem.toJson());
      
      expect(itemFromJson.id, equals(testItem.id));
      expect(itemFromJson.userId, equals(testItem.userId));
      expect(itemFromJson.categoryId, equals(testItem.categoryId));
      expect(itemFromJson.name, equals(testItem.name));
      expect(itemFromJson.targetQuantity, equals(testItem.targetQuantity));
      expect(itemFromJson.currentQuantity, equals(testItem.currentQuantity));
      expect(itemFromJson.unit, equals(testItem.unit));
      expect(itemFromJson.isCompleted, equals(testItem.isCompleted));
      expect(itemFromJson.completedAt, equals(testItem.completedAt));
      expect(itemFromJson.isCustom, equals(testItem.isCustom));
      expect(itemFromJson.syncVersion, equals(testItem.syncVersion));
      expect(itemFromJson.createdAt, equals(testItem.createdAt));
      expect(itemFromJson.updatedAt, equals(testItem.updatedAt));
    });

    test('Should create prep item using factory method', () {
      final newItem = PrepItem.create(
        userId: 'user-uuid-new',
        categoryId: 'category-uuid-new',
        name: 'Canned Food',
        targetQuantity: 50.0,
        unit: 'cans',
        currentQuantity: 10.0,
        isCustom: true,
      );
      
      expect(newItem.id, isNotEmpty);
      expect(newItem.userId, equals('user-uuid-new'));
      expect(newItem.categoryId, equals('category-uuid-new'));
      expect(newItem.name, equals('Canned Food'));
      expect(newItem.targetQuantity, equals(50.0));
      expect(newItem.currentQuantity, equals(10.0));
      expect(newItem.unit, equals('cans'));
      expect(newItem.isCompleted, isFalse);
      expect(newItem.completedAt, isNull);
      expect(newItem.isCustom, isTrue);
      expect(newItem.syncVersion, equals(1));
      expect(newItem.createdAt, isA<DateTime>());
      expect(newItem.updatedAt, isA<DateTime>());
      expect(newItem.createdAt, equals(newItem.updatedAt));
    });

    test('Should update quantity and mark as complete when target reached', () {
      final updatedItem = PrepItem.updateQuantity(
        existing: testItem,
        newQuantity: 30.0, // Reaches target
      );
      
      expect(updatedItem.id, equals(testItem.id));
      expect(updatedItem.currentQuantity, equals(30.0));
      expect(updatedItem.isCompleted, isTrue);
      expect(updatedItem.completedAt, isNotNull);
      expect(updatedItem.syncVersion, equals(2)); // Incremented
      expect(updatedItem.updatedAt, isNot(equals(testItem.updatedAt)));
    });

    test('Should update quantity without marking complete when below target', () {
      final updatedItem = PrepItem.updateQuantity(
        existing: testItem,
        newQuantity: 20.0, // Below target
      );
      
      expect(updatedItem.currentQuantity, equals(20.0));
      expect(updatedItem.isCompleted, isFalse);
      expect(updatedItem.completedAt, isNull);
      expect(updatedItem.syncVersion, equals(2));
    });

    test('Should mark item as complete manually', () {
      final completedItem = PrepItem.markComplete(
        existing: testItem,
        completed: true,
      );
      
      expect(completedItem.isCompleted, isTrue);
      expect(completedItem.completedAt, isNotNull);
      expect(completedItem.syncVersion, equals(2));
      expect(completedItem.currentQuantity, equals(testItem.currentQuantity)); // Unchanged
    });

    test('Should unmark item as complete', () {
      final completedItem = testItem.copyWith(
        isCompleted: true,
        completedAt: DateTime.now(),
      );
      
      final uncompletedItem = PrepItem.markComplete(
        existing: completedItem,
        completed: false,
      );
      
      expect(uncompletedItem.isCompleted, isFalse);
      expect(uncompletedItem.completedAt, isNull);
    });

    test('Should handle copyWith correctly', () {
      final updatedItem = testItem.copyWith(
        name: 'Updated Water',
        currentQuantity: 25.0,
        isCompleted: true,
      );
      
      expect(updatedItem.id, equals(testItem.id));
      expect(updatedItem.name, equals('Updated Water'));
      expect(updatedItem.currentQuantity, equals(25.0));
      expect(updatedItem.isCompleted, isTrue);
      expect(updatedItem.targetQuantity, equals(testItem.targetQuantity));
      expect(updatedItem.unit, equals(testItem.unit));
    });

    test('Should handle default values correctly', () {
      final minimalJson = {
        'id': 'item-minimal',
        'userId': 'user-minimal',
        'categoryId': 'category-minimal',
        'name': 'Minimal Item',
        'targetQuantity': 10.0,
        'unit': 'pieces',
        'createdAt': '2024-01-16T12:00:00.000Z',
        'updatedAt': '2024-01-16T12:00:00.000Z',
      };
      
      final itemFromJson = PrepItem.fromJson(minimalJson);
      
      expect(itemFromJson.currentQuantity, equals(0.0)); // Default
      expect(itemFromJson.isCompleted, isFalse); // Default
      expect(itemFromJson.completedAt, isNull);
      expect(itemFromJson.isCustom, isFalse); // Default
      expect(itemFromJson.syncVersion, equals(1)); // Default
    });

    test('Should track sync version for conflict resolution', () {
      var item = testItem;
      
      // Simulate multiple updates
      item = PrepItem.updateQuantity(existing: item, newQuantity: 20.0);
      expect(item.syncVersion, equals(2));
      
      item = PrepItem.updateQuantity(existing: item, newQuantity: 25.0);
      expect(item.syncVersion, equals(3));
      
      item = PrepItem.markComplete(existing: item, completed: true);
      expect(item.syncVersion, equals(4));
    });

    test('Should handle different unit types', () {
      final units = ['liters', 'days', 'pieces', 'kg', 'cans'];
      
      for (final unit in units) {
        final item = PrepItem.create(
          userId: 'test-user',
          categoryId: 'test-category',
          name: 'Test Item',
          targetQuantity: 10.0,
          unit: unit,
        );
        
        expect(item.unit, equals(unit));
        
        final json = item.toJson();
        final itemFromJson = PrepItem.fromJson(json);
        expect(itemFromJson.unit, equals(unit));
      }
    });

    test('Should handle custom items correctly', () {
      final customItem = PrepItem.create(
        userId: 'test-user',
        categoryId: 'test-category',
        name: 'Custom Item',
        targetQuantity: 5.0,
        unit: 'pieces',
        isCustom: true,
      );
      
      expect(customItem.isCustom, isTrue);
      
      final json = customItem.toJson();
      final itemFromJson = PrepItem.fromJson(json);
      expect(itemFromJson.isCustom, isTrue);
    });

    test('Should calculate completion percentage', () {
      // 50% complete
      expect(testItem.currentQuantity / testItem.targetQuantity, equals(0.5));
      
      // 100% complete
      final completeItem = testItem.copyWith(currentQuantity: 30.0);
      expect(completeItem.currentQuantity / completeItem.targetQuantity, equals(1.0));
      
      // Over 100%
      final overItem = testItem.copyWith(currentQuantity: 40.0);
      expect(overItem.currentQuantity / overItem.targetQuantity, greaterThan(1.0));
    });
  });
}
