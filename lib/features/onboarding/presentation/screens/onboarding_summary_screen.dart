import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../models/household_profile_model.dart';
import '../../../../models/user_model.dart';
import '../providers/onboarding_provider.dart';
import '../../../preparedness/domain/services/preparedness_calculator.dart';
import '../../../home/presentation/providers/home_provider.dart';

class OnboardingSummaryScreen extends ConsumerWidget {
  const OnboardingSummaryScreen({super.key});

  String _getHousingTypeLabel(HousingType type) {
    switch (type) {
      case HousingType.apartment:
        return 'Lägenhet';
      case HousingType.house:
        return 'Villa/Radhus';
      case HousingType.rural:
        return 'Lantbruk/Landsbygd';
    }
  }

  String _getHouseholdSummary(int adults, int children, int infants) {
    final parts = <String>[];
    if (adults > 0) parts.add('$adults ${adults == 1 ? 'vuxen' : 'vuxna'}');
    if (children > 0) parts.add('$children barn');
    if (infants > 0) parts.add('$infants ${infants == 1 ? 'spädbarn' : 'spädbarn'}');
    return parts.join(', ');
  }

  Future<void> _completeOnboarding(BuildContext context, WidgetRef ref) async {
    final onboardingState = ref.read(onboardingProvider);
    
    if (onboardingState.postalCode == null || onboardingState.housingType == null) {
      return;
    }

    try {
      // Create user
      final user = User.createGuest();

      // Create household profile
      final profile = HouseholdProfile.create(
        userId: user.id,
        postalCode: onboardingState.postalCode!,
        housingType: onboardingState.housingType!,
        heatingType: HeatingType.electric,
        adultCount: onboardingState.adultCount,
        childCount: onboardingState.childCount,
        infantCount: onboardingState.infantCount,
        allowAggregation: onboardingState.allowAggregation,
      );

      // Save to Hive
      final userBox = await Hive.openBox<User>('users');
      await userBox.put(user.id, user);

      final profileBox = await Hive.openBox<HouseholdProfile>('household_profiles');
      await profileBox.put(profile.id, profile);

      // Generate preparedness items
      final calculator = PreparednessCalculator();
      final items = calculator.calculateRequirements(
        profile: profile,
        userId: user.id,
      );

      // Save items to Hive
      final itemsBox = await Hive.openBox('prep_items');
      for (final item in items) {
        await itemsBox.put(item.id, item);
      }

      // Load data into home provider
      await ref.read(homeProvider.notifier).loadDataFromHive(user.id);

      // Navigate to home
      if (context.mounted) {
        context.go('/home');
      }
    } catch (e) {
      print('Error completing onboarding: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fel vid sparande: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Din beredskapsprofil'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    size: 64,
                    color: Colors.green[700],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Profilen är klar!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Baserat på ditt hushåll har vi beräknat dina beredskapsbehov',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView(
                  children: [
                    _SummaryCard(
                      icon: Icons.location_on,
                      title: 'Postnummer',
                      value: onboardingState.postalCode ?? 'Ej angivet',
                    ),
                    const SizedBox(height: 12),
                    _SummaryCard(
                      icon: Icons.home,
                      title: 'Boendetyp',
                      value: onboardingState.housingType != null
                          ? _getHousingTypeLabel(onboardingState.housingType!)
                          : 'Ej angivet',
                    ),
                    const SizedBox(height: 12),
                    _SummaryCard(
                      icon: Icons.people,
                      title: 'Hushåll',
                      value: _getHouseholdSummary(
                        onboardingState.adultCount,
                        onboardingState.childCount,
                        onboardingState.infantCount,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _SummaryCard(
                      icon: Icons.privacy_tip,
                      title: 'Dela statistik',
                      value: onboardingState.allowAggregation ? 'Ja' : 'Nej',
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.blue[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Beredskapsnivåer',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900],
                                ),
                          ),
                          const SizedBox(height: 16),
                          _ProgressRow(
                            label: '24 timmar',
                            completed: 0,
                            total: 8,
                          ),
                          const SizedBox(height: 12),
                          _ProgressRow(
                            label: '72 timmar',
                            completed: 0,
                            total: 15,
                          ),
                          const SizedBox(height: 12),
                          _ProgressRow(
                            label: '7 dagar',
                            completed: 0,
                            total: 25,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.amber[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.amber[200]!),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.lightbulb_outline, color: Colors.amber[700]),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Börja med 24-timmars beredskap för snabba resultat!',
                              style: TextStyle(color: Colors.amber[900]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _completeOnboarding(context, ref),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Börja förbereda',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _SummaryCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  final String label;
  final int completed;
  final int total;

  const _ProgressRow({
    required this.label,
    required this.completed,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: completed / total,
                  backgroundColor: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '$completed av $total',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[700],
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
