import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/localization/app_localizations.dart';
import '../providers/home_provider.dart';
import '../widgets/readiness_card.dart';
import '../widgets/category_card.dart';
import '../widgets/next_step_item.dart';
import '../../../preparedness/presentation/screens/category_detail_screen.dart';
import '../../../settings/presentation/screens/settings_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('HomeScreen: Loading data...');
      ref.read(homeProvider.notifier).loadData();
    });
  }

  String _getGreeting(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.t('good_morning');
    if (hour < 18) return l10n.t('good_day');
    return l10n.t('good_evening');
  }

  Future<void> _syncData() async {
    setState(() => _isSyncing = true);

    try {
      // Sync all data
      await ref.read(homeProvider.notifier).loadData();
      await ref.read(homeProvider.notifier).refreshProgress();

      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 8),
                Text(l10n.t('synced')),
              ],
            ),
            backgroundColor: const Color(0xFF4CAF50),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.t('sync_failed')}: ${e.toString()}'),
            backgroundColor: const Color(0xFFF44336),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSyncing = false);
      }
    }
  }

  Widget _buildMaintenanceItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF005AA0).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 24,
            color: const Color(0xFF005AA0),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const Icon(
          Icons.chevron_right,
          color: Color(0xFFB0B0B0),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final homeState = ref.watch(homeProvider);
    
    // Check if user is 100% complete
    final isFullyPrepared = homeState.progress24h >= 100 && 
                            homeState.progress72h >= 100 && 
                            homeState.progress7d >= 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Civil Beredskap'),
        actions: [
          IconButton(
            icon: _isSyncing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.refresh),
            onPressed: _isSyncing ? null : _syncData,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: homeState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : homeState.error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.red),
                      const SizedBox(height: 16),
                      Text('Error: ${homeState.error}'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref.read(homeProvider.notifier).loadData(),
                        child: Text(l10n.t('try_again')),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () => ref.read(homeProvider.notifier).loadData(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Greeting
                        Text(
                          _getGreeting(context),
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.t('readiness_status'),
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                        const SizedBox(height: 24),

                        // Readiness Overview
                        Row(
                          children: [
                            Expanded(
                              child: ReadinessCard(
                                level: '24h',
                                percentage: homeState.progress24h,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ReadinessCard(
                                level: '72h',
                                percentage: homeState.progress72h,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ReadinessCard(
                                level: '7 dagar',
                                percentage: homeState.progress7d,
                              ),
                            ),
                          ],
                        ),
                        
                        // Success message when fully prepared
                        if (isFullyPrepared) ...[
                          const SizedBox(height: 24),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF1B5E20),
                                  Color(0xFF2E7D32),
                                ],
                              ),
                              border: Border.all(
                                color: const Color(0xFF4CAF50),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF4CAF50).withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0.0, end: 1.0),
                                  duration: const Duration(milliseconds: 800),
                                  curve: Curves.elasticOut,
                                  builder: (context, value, child) {
                                    return Transform.scale(
                                      scale: value,
                                      child: const Text(
                                        '🎉',
                                        style: TextStyle(fontSize: 32),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Du är helt förberedd!',
                                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Din beredskap är komplett för alla scenarier. Bra jobbat!',
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: Colors.white.withOpacity(0.9),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 32),

                        // Categories Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Kategorier',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Navigate to all categories
                              },
                              child: const Text('Visa alla'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.0,
                          ),
                          itemCount: homeState.categories.length,
                          itemBuilder: (context, index) {
                            final category = homeState.categories[index];
                            final progress = homeState.categoryProgress[category.id] ?? 0.0;
                            return CategoryCard(
                              category: category,
                              progress: progress,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryDetailScreen(
                                      categoryId: category.id,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 32),

                        // Next Steps or Maintenance Section
                        if (isFullyPrepared) ...[
                          // Maintenance section for 100% complete state
                          Text(
                            '🔄 Underhåll & Kontroll',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFF3A3A3A),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildMaintenanceItem(
                                  context,
                                  Icons.water_drop,
                                  'Rotera vatten',
                                  'Om 4 månader',
                                ),
                                const SizedBox(height: 12),
                                _buildMaintenanceItem(
                                  context,
                                  Icons.restaurant,
                                  'Kontrollera mat',
                                  'Om 2 månader',
                                ),
                                const SizedBox(height: 12),
                                _buildMaintenanceItem(
                                  context,
                                  Icons.lightbulb,
                                  'Testa ficklampa',
                                  'Om 6 månader',
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.notifications_active,
                                      size: 20,
                                      color: Color(0xFF005AA0),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Påminnelser aktiverade',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: const Color(0xFF005AA0),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ] else if (homeState.nextSteps.isNotEmpty) ...[
                          // Next steps for incomplete state
                          Text(
                            'Nästa viktiga steg',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 16),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: homeState.nextSteps.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final item = homeState.nextSteps[index];
                              return NextStepItem(
                                item: item,
                                onTap: () {
                                  // Navigate to item detail
                                },
                                onCheckChanged: (value) {
                                  ref.read(homeProvider.notifier).markItemComplete(
                                        item.id,
                                        value ?? false,
                                      );
                                },
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
    );
  }
}
