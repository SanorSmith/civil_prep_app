import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/onboarding/presentation/screens/postal_code_screen.dart';
import '../../features/onboarding/presentation/screens/household_profile_screen.dart';
import '../../features/onboarding/presentation/screens/household_size_screen.dart';
import '../../features/onboarding/presentation/screens/special_needs_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_summary_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/onboarding',
    routes: [
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
