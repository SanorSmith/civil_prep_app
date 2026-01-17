import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../models/household_profile_model.dart';
import '../../../../core/localization/app_localizations.dart';
import '../providers/onboarding_provider.dart';

class HouseholdProfileScreen extends ConsumerStatefulWidget {
  final String postalCode;

  const HouseholdProfileScreen({
    super.key,
    required this.postalCode,
  });

  @override
  ConsumerState<HouseholdProfileScreen> createState() => _HouseholdProfileScreenState();
}

class _HouseholdProfileScreenState extends ConsumerState<HouseholdProfileScreen> {
  HousingType? _selectedHousingType;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onboardingProvider.notifier).setPostalCode(widget.postalCode);
    });
  }

  void _onHousingTypeSelected(HousingType type) {
    setState(() {
      _selectedHousingType = type;
    });
    ref.read(onboardingProvider.notifier).setHousingType(type);
  }

  void _onNextPressed() {
    if (_selectedHousingType != null) {
      context.go('/onboarding/household-size');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.t('app_name')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/onboarding/postal-code'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Text(
                l10n.t('step_2_of_4'),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.t('housing_situation'),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.t('housing_situation_desc'),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView(
                  children: [
                    _HousingTypeCard(
                      icon: Icons.apartment,
                      title: l10n.t('apartment'),
                      description: l10n.t('apartment_desc'),
                      housingType: HousingType.apartment,
                      isSelected: _selectedHousingType == HousingType.apartment,
                      onTap: () => _onHousingTypeSelected(HousingType.apartment),
                    ),
                    const SizedBox(height: 16),
                    _HousingTypeCard(
                      icon: Icons.home,
                      title: l10n.t('house'),
                      description: l10n.t('house_desc'),
                      housingType: HousingType.house,
                      isSelected: _selectedHousingType == HousingType.house,
                      onTap: () => _onHousingTypeSelected(HousingType.house),
                    ),
                    const SizedBox(height: 16),
                    _HousingTypeCard(
                      icon: Icons.landscape,
                      title: l10n.t('rural'),
                      description: l10n.t('rural_desc'),
                      housingType: HousingType.rural,
                      isSelected: _selectedHousingType == HousingType.rural,
                      onTap: () => _onHousingTypeSelected(HousingType.rural),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _selectedHousingType != null ? _onNextPressed : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  l10n.t('next_btn'),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.go('/onboarding/postal-code'),
                child: Text(l10n.t('back')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HousingTypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final HousingType housingType;
  final bool isSelected;
  final VoidCallback onTap;

  const _HousingTypeCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.housingType,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 32,
                color: isSelected ? Colors.white : Colors.grey[700],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.primary,
                size: 28,
              ),
          ],
        ),
      ),
    );
  }
}
