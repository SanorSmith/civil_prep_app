import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../models/household_profile_model.dart';
import '../../../../models/user_model.dart';
import '../../../../core/services/storage_service.dart';
import '../providers/onboarding_provider.dart';
import '../../../preparedness/domain/services/preparedness_calculator.dart';
import '../../../home/presentation/providers/home_provider.dart';
import '../../../../core/localization/app_localizations.dart';

class OnboardingSummaryScreen extends ConsumerWidget {
  const OnboardingSummaryScreen({super.key});

  String _getHousingTypeLabel(BuildContext context, HousingType type) {
    final l10n = AppLocalizations.of(context);
    switch (type) {
      case HousingType.apartment:
        return l10n.t('apartment');
      case HousingType.house:
        return l10n.t('house');
      case HousingType.rural:
        return l10n.t('rural');
    }
  }

  String _getHouseholdSummary(BuildContext context, int adults, int children, int infants) {
    final l10n = AppLocalizations.of(context);
    final parts = <String>[];
    if (adults > 0) parts.add('$adults ${adults == 1 ? l10n.t('adult_singular') : l10n.t('adults').toLowerCase()}');
    if (children > 0) parts.add('$children ${l10n.t('children').toLowerCase()}');
    if (infants > 0) parts.add('$infants ${l10n.t('infants').toLowerCase()}');
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

      // Save to SharedPreferences (no Hive adapters needed!)
      await StorageService.saveUserProfile(user);
      await StorageService.saveHouseholdProfile(profile);

      // Generate preparedness items
      final calculator = PreparednessCalculator();
      final items = calculator.calculateRequirements(
        profile: profile,
        userId: user.id,
      );

      // Save items to Hive (PrepItem adapters are registered)
      final itemsBox = await Hive.openBox('prep_items');
      for (final item in items) {
        await itemsBox.put(item.id, item);
      }

      // Load data into home provider
      await ref.read(homeProvider.notifier).loadDataFromStorage();

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
    final l10n = AppLocalizations.of(context);
    final onboardingState = ref.watch(onboardingProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.t('app_name')),
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
                l10n.t('profile_complete'),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.t('profile_desc'),
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
                      title: l10n.t('postal_code'),
                      value: onboardingState.postalCode ?? l10n.t('not_specified'),
                    ),
                    const SizedBox(height: 12),
                    _SummaryCard(
                      icon: Icons.home,
                      title: l10n.t('housing_type'),
                      value: onboardingState.housingType != null
                          ? _getHousingTypeLabel(context, onboardingState.housingType!)
                          : l10n.t('not_specified'),
                    ),
                    const SizedBox(height: 12),
                    _SummaryCard(
                      icon: Icons.people,
                      title: l10n.t('household'),
                      value: _getHouseholdSummary(
                        context,
                        onboardingState.adultCount,
                        onboardingState.childCount,
                        onboardingState.infantCount,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _SummaryCard(
                      icon: Icons.privacy_tip,
                      title: l10n.t('share_data'),
                      value: onboardingState.allowAggregation ? l10n.t('yes') : l10n.t('no'),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFBBDEFB)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.t('preparedness_levels'),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF005AA0),
                                ),
                          ),
                          const SizedBox(height: 16),
                          _ProgressRow(
                            label: l10n.t('24_hours'),
                            completed: 0,
                            total: 8,
                          ),
                          const SizedBox(height: 12),
                          _ProgressRow(
                            label: l10n.t('72_hours'),
                            completed: 0,
                            total: 15,
                          ),
                          const SizedBox(height: 12),
                          _ProgressRow(
                            label: l10n.t('7_days'),
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
                              l10n.t('start_24h'),
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
                child: Text(
                  l10n.t('start_preparing'),
                  style: const TextStyle(fontSize: 16),
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
    final l10n = AppLocalizations.of(context);
    
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF212121),
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
                  backgroundColor: const Color(0xFFE0E0E0),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF9E9E9E)),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '$completed ${l10n.t('of')} $total',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF424242),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
