import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/app_localizations.dart';
import '../providers/onboarding_provider.dart';

class HouseholdSizeScreen extends ConsumerStatefulWidget {
  const HouseholdSizeScreen({super.key});

  @override
  ConsumerState<HouseholdSizeScreen> createState() => _HouseholdSizeScreenState();
}

class _HouseholdSizeScreenState extends ConsumerState<HouseholdSizeScreen> {
  int _adultCount = 1;
  int _childCount = 0;
  int _infantCount = 0;

  int get _totalCount => _adultCount + _childCount + _infantCount;

  void _incrementAdults() {
    if (_adultCount < 10) {
      setState(() => _adultCount++);
    }
  }

  void _decrementAdults() {
    if (_adultCount > 1) {
      setState(() => _adultCount--);
    }
  }

  void _incrementChildren() {
    if (_childCount < 10) {
      setState(() => _childCount++);
    }
  }

  void _decrementChildren() {
    if (_childCount > 0) {
      setState(() => _childCount--);
    }
  }

  void _incrementInfants() {
    if (_infantCount < 5) {
      setState(() => _infantCount++);
    }
  }

  void _decrementInfants() {
    if (_infantCount > 0) {
      setState(() => _infantCount--);
    }
  }

  void _onNextPressed() {
    ref.read(onboardingProvider.notifier).setHouseholdSize(
          adults: _adultCount,
          children: _childCount,
          infants: _infantCount,
        );
    context.go('/onboarding/special-needs');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.t('app_name')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/onboarding/household-profile'),
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
                l10n.t('step_3_of_4'),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.t('household_size'),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.t('household_size_desc'),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView(
                  children: [
                    _CounterRow(
                      label: l10n.t('adults'),
                      subtitle: l10n.t('adults_age'),
                      count: _adultCount,
                      onIncrement: _incrementAdults,
                      onDecrement: _decrementAdults,
                      minValue: 1,
                      maxValue: 10,
                    ),
                    const SizedBox(height: 20),
                    _CounterRow(
                      label: l10n.t('children'),
                      subtitle: l10n.t('children_age'),
                      count: _childCount,
                      onIncrement: _incrementChildren,
                      onDecrement: _decrementChildren,
                      minValue: 0,
                      maxValue: 10,
                    ),
                    const SizedBox(height: 20),
                    _CounterRow(
                      label: l10n.t('infants'),
                      subtitle: l10n.t('infants_age'),
                      count: _infantCount,
                      onIncrement: _incrementInfants,
                      onDecrement: _decrementInfants,
                      minValue: 0,
                      maxValue: 5,
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${l10n.t('total')}: $_totalCount ${_totalCount == 1 ? l10n.t('person') : l10n.t('people')}',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
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
                onPressed: _onNextPressed,
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
                onPressed: () => context.go('/onboarding/household-profile'),
                child: Text(l10n.t('back')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CounterRow extends StatelessWidget {
  final String label;
  final String subtitle;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final int minValue;
  final int maxValue;

  const _CounterRow({
    required this.label,
    required this.subtitle,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
    required this.minValue,
    required this.maxValue,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: count > minValue ? onDecrement : null,
                icon: const Icon(Icons.remove_circle_outline),
                iconSize: 32,
                color: count > minValue
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[400],
              ),
              Container(
                width: 50,
                alignment: Alignment.center,
                child: Text(
                  count.toString(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              IconButton(
                onPressed: count < maxValue ? onIncrement : null,
                icon: const Icon(Icons.add_circle_outline),
                iconSize: 32,
                color: count < maxValue
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[400],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
