import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Civil Beredskap'),
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
              const Text(
                'Steg 4 av 4',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Särskilda behov',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Finns det något vi bör veta?',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView(
                  children: [
                    CheckboxListTile(
                      title: const Text('Medicinsk utrustning som kräver el'),
                      subtitle: const Text('T.ex. syrgaskoncentrator, CPAP'),
                      value: _hasMedicalEquipment,
                      onChanged: (value) {
                        setState(() => _hasMedicalEquipment = value ?? false);
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                    CheckboxListTile(
                      title: const Text('Husdjur'),
                      subtitle: _hasPets
                          ? Text('Antal: $_petCount')
                          : const Text('Katt, hund, eller andra djur'),
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
                            const Text('Antal husdjur:'),
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
                      title: const Text('Rörelsehinder'),
                      subtitle: const Text('Begränsad rörlighet'),
                      value: _hasLimitedMobility,
                      onChanged: (value) {
                        setState(() => _hasLimitedMobility = value ?? false);
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                    CheckboxListTile(
                      title: const Text('Matallergier'),
                      subtitle: const Text('Celiaki, laktos, nötter, etc.'),
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
                        labelText: 'Annan information (valfritt)',
                        hintText: 'T.ex. särskilda mediciner, behov...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.privacy_tip, color: Colors.blue[700]),
                              const SizedBox(width: 8),
                              Text(
                                'Integritet',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[700],
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SwitchListTile(
                            title: const Text('Dela anonym statistik'),
                            subtitle: const Text(
                              'Hjälp andra i ditt område genom att anonymt dela dina framsteg',
                            ),
                            value: _allowAggregation,
                            onChanged: (value) {
                              setState(() => _allowAggregation = value);
                            },
                            contentPadding: EdgeInsets.zero,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Din data skyddas med k-anonymitet. Vi visar endast områdesstatistik när minst 50 hushåll deltar.',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.grey[700],
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
                child: const Text(
                  'Slutför',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.go('/onboarding/household-size'),
                child: const Text('Tillbaka'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
