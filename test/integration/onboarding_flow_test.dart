import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:civil_prep_app/app.dart';

void main() {
  group('Onboarding Flow Integration Tests', () {
    testWidgets('complete onboarding flow from start to finish', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: CivilPrepApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Step 1: Welcome screen
      expect(find.text('Civil Beredskap'), findsOneWidget);
      expect(find.text('Kom igång'), findsOneWidget);

      // Tap "Kom igång" button
      await tester.tap(find.text('Kom igång'));
      await tester.pumpAndSettle();

      // Step 2: Postal code screen
      expect(find.text('Var bor du?'), findsOneWidget);

      // Enter valid postal code
      await tester.enterText(find.byType(TextField), '11522');
      await tester.pumpAndSettle();

      // Tap next button
      await tester.tap(find.text('Nästa'));
      await tester.pumpAndSettle();

      // Step 3: Housing type screen
      expect(find.text('Vilken typ av boende har du?'), findsOneWidget);

      // Select apartment (Lägenhet)
      await tester.tap(find.text('Lägenhet'));
      await tester.pumpAndSettle();

      // Tap next button
      await tester.tap(find.text('Nästa'));
      await tester.pumpAndSettle();

      // Step 4: Household size screen
      expect(find.text('Hur många bor i hushållet?'), findsOneWidget);

      // Default should be 1 adult, 0 children, 0 infants
      // Add 1 more adult (total 2)
      final adultPlusButtons = find.byIcon(Icons.add);
      await tester.tap(adultPlusButtons.first);
      await tester.pumpAndSettle();

      // Add 1 child
      await tester.tap(adultPlusButtons.at(1));
      await tester.pumpAndSettle();

      // Tap next button
      await tester.tap(find.text('Nästa'));
      await tester.pumpAndSettle();

      // Step 5: Special needs screen
      expect(find.text('Finns det särskilda behov?'), findsOneWidget);

      // Toggle privacy setting
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      // Tap complete button
      await tester.tap(find.text('Slutför'));
      await tester.pumpAndSettle();

      // Step 6: Summary screen
      expect(find.text('Profilen är klar!'), findsOneWidget);
      expect(find.text('11522'), findsOneWidget);
      expect(find.text('Lägenhet'), findsOneWidget);

      // Tap "Börja förbereda" button
      await tester.tap(find.text('Börja förbereda'));
      await tester.pumpAndSettle();

      // Should navigate to home dashboard
      expect(find.text('Civil Beredskap'), findsOneWidget);
      // Should show readiness cards
      expect(find.text('24h'), findsOneWidget);
      expect(find.text('72h'), findsOneWidget);
      expect(find.text('7 dagar'), findsOneWidget);
    });

    testWidgets('onboarding saves data correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: CivilPrepApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Complete onboarding with specific data
      await tester.tap(find.text('Kom igång'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), '41301'); // Göteborg
      await tester.pumpAndSettle();
      await tester.tap(find.text('Nästa'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Villa/Radhus'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Nästa'));
      await tester.pumpAndSettle();

      // Set household: 1 adult (default), add 2 children
      final childPlusButton = find.byIcon(Icons.add).at(1);
      await tester.tap(childPlusButton);
      await tester.pumpAndSettle();
      await tester.tap(childPlusButton);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Nästa'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Slutför'));
      await tester.pumpAndSettle();

      // Verify data on summary screen
      expect(find.text('41301'), findsOneWidget);
      expect(find.text('Villa/Radhus'), findsOneWidget);
      expect(find.textContaining('1 vuxen'), findsOneWidget);
      expect(find.textContaining('2 barn'), findsOneWidget);

      // Complete onboarding
      await tester.tap(find.text('Börja förbereda'));
      await tester.pumpAndSettle();

      // Verify items were generated based on household
      // For 1 adult + 2 children:
      // Water: 3L + 2*2L = 7L per day
      // Should see categories and items
      expect(find.text('Kategorier'), findsOneWidget);
    });

    testWidgets('can skip onboarding', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: CivilPrepApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap "Hoppa över" button
      await tester.tap(find.text('Hoppa över'));
      await tester.pumpAndSettle();

      // Should navigate directly to home with mock data
      expect(find.text('Civil Beredskap'), findsOneWidget);
      expect(find.text('Kategorier'), findsOneWidget);
    });
  });
}
