import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/app_localizations.dart';
import '../providers/onboarding_provider.dart';

class SpecialNeedsScreen extends ConsumerStatefulWidget {
  const SpecialNeedsScreen({super.key});

  @override
  ConsumerState<SpecialNeedsScreen> createState() => _SpecialNeedsScreenState();
}

class _SpecialNeedsScreenState extends ConsumerState<SpecialNeedsScreen> {
  bool _hasMedicalEquipment = false;
  bool _hasPets = false;
  int _petCount = 1;
  bool _hasLimitedMobility = false;
  bool _hasAllergies = false;
  bool _allowAggregation = true;
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _onCompletePressed() {
    ref.read(onboardingProvider.notifier).setAllowAggregation(_allowAggregation);
    context.go('/onboarding/summary');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.t('app_name')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/onboarding/household-size'),
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
                l10n.t('step_4_of_4'),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.t('special_needs'),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.t('special_needs_desc'),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView(
                  children: [
                    CheckboxListTile(
                      title: Text(l10n.t('medical_equipment')),
                      subtitle: Text(l10n.t('medical_equipment_desc')),
                      value: _hasMedicalEquipment,
                      onChanged: (value) {
                        setState(() => _hasMedicalEquipment = value ?? false);
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                    CheckboxListTile(
                      title: Text(l10n.t('pets')),
                      subtitle: _hasPets
                          ? Text('${l10n.t('pet_count')}: $_petCount')
                          : Text(l10n.t('pets_desc')),
                      value: _hasPets,
                      onChanged: (value) {
                        setState(() => _hasPets = value ?? false);
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                    if (_hasPets)
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 16),
                        child: Row(
                          children: [
                            Text('${l10n.t('pet_count')}:'),
                            const SizedBox(width: 16),
                            IconButton(
                              onPressed: _petCount > 1
                                  ? () => setState(() => _petCount--)
                                  : null,
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text(
                              _petCount.toString(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            IconButton(
                              onPressed: _petCount < 5
                                  ? () => setState(() => _petCount++)
                                  : null,
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),
                      ),
                    CheckboxListTile(
                      title: Text(l10n.t('mobility')),
                      subtitle: Text(l10n.t('mobility_desc')),
                      value: _hasLimitedMobility,
                      onChanged: (value) {
                        setState(() => _hasLimitedMobility = value ?? false);
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                    CheckboxListTile(
                      title: Text(l10n.t('allergies')),
                      subtitle: Text(l10n.t('allergies_desc')),
                      value: _hasAllergies,
                      onChanged: (value) {
                        setState(() => _hasAllergies = value ?? false);
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _notesController,
                      maxLines: 3,
                      maxLength: 200,
                      decoration: InputDecoration(
                        labelText: l10n.t('other_info'),
                        hintText: l10n.t('other_info_hint'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFBBDEFB)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.privacy_tip, color: Color(0xFF005AA0)),
                              const SizedBox(width: 8),
                              Text(
                                l10n.t('privacy'),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF005AA0),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SwitchListTile(
                            title: Text(
                              l10n.t('share_data'),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF212121),
                              ),
                            ),
                            subtitle: Text(
                              l10n.t('share_data_desc'),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF424242),
                              ),
                            ),
                            value: _allowAggregation,
                            onChanged: (value) {
                              setState(() => _allowAggregation = value);
                            },
                            contentPadding: EdgeInsets.zero,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.t('privacy_explanation'),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF424242),
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
                onPressed: _onCompletePressed,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  l10n.t('finish'),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.go('/onboarding/household-size'),
                child: Text(l10n.t('back')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
