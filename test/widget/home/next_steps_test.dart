import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:civil_prep_app/features/home/presentation/widgets/next_step_item.dart';
import 'package:civil_prep_app/models/prep_item_model.dart';

void main() {
  group('NextStepItem Widget Tests - CRITICAL', () {
    late PrepItem testItem;

    setUp(() {
      testItem = PrepItem(
        id: 'test-item-1',
        userId: 'test-user',
        categoryId: 'water',
        name: 'Vattenreningstabletter',
        targetQuantity: 100,
        currentQuantity: 0,
        unit: 'st',
        isCompleted: false,
        completedAt: null,
        isCustom: false,
        syncVersion: 1,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    });

    testWidgets('displays item with checkbox', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NextStepItem(
              item: testItem,
              onTap: () {},
              onCheckChanged: (value) {},
            ),
          ),
        ),
      );

      // Verify item name displays
      expect(find.text('Vattenreningstabletter'), findsOneWidget);

      // Verify quantity displays
      expect(find.text('100 st'), findsOneWidget);

      // Verify checkbox exists
      expect(find.byType(Checkbox), findsOneWidget);

      // Verify checkbox is unchecked
      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, false);
    });

    testWidgets('CRITICAL: checkbox tap calls onCheckChanged', (WidgetTester tester) async {
      bool? capturedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NextStepItem(
              item: testItem,
              onTap: () {},
              onCheckChanged: (value) {
                capturedValue = value;
              },
            ),
          ),
        ),
      );

      // Tap the checkbox
      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      // Verify callback was called with true
      expect(capturedValue, true);
    });

    testWidgets('CRITICAL: checked item displays as checked', (WidgetTester tester) async {
      final checkedItem = PrepItem(
        id: 'test-item-2',
        userId: 'test-user',
        categoryId: 'water',
        name: 'Vattenreningstabletter',
        targetQuantity: 100,
        currentQuantity: 100, // Fully acquired
        unit: 'st',
        isCompleted: true,
        completedAt: DateTime.now(),
        isCustom: false,
        syncVersion: 1,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NextStepItem(
              item: checkedItem,
              onTap: () {},
              onCheckChanged: (value) {},
            ),
          ),
        ),
      );

      // Verify checkbox is checked
      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, true);
    });

    testWidgets('displays category icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NextStepItem(
              item: testItem,
              onTap: () {},
              onCheckChanged: (value) {},
            ),
          ),
        ),
      );

      // Verify icon exists (water drop icon for water category)
      expect(find.byIcon(Icons.water_drop), findsOneWidget);
    });

    testWidgets('item is tappable', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NextStepItem(
              item: testItem,
              onTap: () {
                tapped = true;
              },
              onCheckChanged: (value) {},
            ),
          ),
        ),
      );

      // Tap the item (not the checkbox)
      await tester.tap(find.text('Vattenreningstabletter'));
      await tester.pump();

      // Verify onTap was called
      expect(tapped, true);
    });
  });

  group('NextStepItem Integration Tests - CRITICAL', () {
    testWidgets('CRITICAL: checkbox updates item quantity correctly', (WidgetTester tester) async {
      // This test verifies the critical requirement:
      // When checkbox is checked, currentQuantity should equal targetQuantity
      // When unchecked, currentQuantity should equal 0

      PrepItem currentItem = PrepItem(
        id: 'test-item-3',
        userId: 'test-user',
        categoryId: 'food',
        name: 'Konserver',
        targetQuantity: 18,
        currentQuantity: 0,
        unit: 'st',
        isCompleted: false,
        completedAt: null,
        isCustom: false,
        syncVersion: 1,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return NextStepItem(
                    item: currentItem,
                    onTap: () {},
                    onCheckChanged: (value) {
                      setState(() {
                        // This simulates what markItemComplete should do
                        currentItem = PrepItem.markComplete(
                          existing: currentItem,
                          completed: value ?? false,
                        );
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ),
      );

      // Initial state: unchecked, quantity = 0
      expect(currentItem.currentQuantity, 0);
      expect(currentItem.isCompleted, false);

      // Check the checkbox
      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();

      // After checking: quantity should equal target
      expect(currentItem.currentQuantity, 18);
      expect(currentItem.isCompleted, true);

      // Uncheck the checkbox
      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();

      // After unchecking: quantity should be 0
      expect(currentItem.currentQuantity, 0);
      expect(currentItem.isCompleted, false);
    });
  });
}
