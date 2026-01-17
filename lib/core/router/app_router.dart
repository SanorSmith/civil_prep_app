import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/language/presentation/screens/language_selection_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/onboarding/presentation/screens/postal_code_screen.dart';
import '../../features/onboarding/presentation/screens/household_profile_screen.dart';
import '../../features/onboarding/presentation/screens/household_size_screen.dart';
import '../../features/onboarding/presentation/screens/special_needs_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_summary_screen.dart';
import '../services/storage_service.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/language',
    redirect: (context, state) async {
      // Check if language is already set
      final savedLanguage = await StorageService.getLanguage();
      
      // If on language screen and language is already set, redirect to onboarding
      if (state.matchedLocation == '/language' && savedLanguage != null) {
        return '/onboarding';
      }
      
      // If not on language screen and language is not set, redirect to language
      if (state.matchedLocation != '/language' && savedLanguage == null) {
        return '/language';
      }
      
      return null; // No redirect needed
    },
    routes: [
      GoRoute(
        path: '/language',
        name: 'language',
        builder: (context, state) => const LanguageSelectionScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/onboarding/postal-code',
        name: 'postal-code',
        builder: (context, state) => const PostalCodeScreen(),
      ),
      GoRoute(
        path: '/onboarding/household-profile',
        name: 'household-profile',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final postalCode = extra?['postalCode'] as String? ?? '';
          return HouseholdProfileScreen(postalCode: postalCode);
        },
      ),
      GoRoute(
        path: '/onboarding/household-size',
        name: 'household-size',
        builder: (context, state) => const HouseholdSizeScreen(),
      ),
      GoRoute(
        path: '/onboarding/special-needs',
        name: 'special-needs',
        builder: (context, state) => const SpecialNeedsScreen(),
      ),
      GoRoute(
        path: '/onboarding/summary',
        name: 'onboarding-summary',
        builder: (context, state) => const OnboardingSummaryScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
});
