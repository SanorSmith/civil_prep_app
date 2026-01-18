import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/services/items_service.dart';
import '../../../../core/services/next_step_service.dart';
import '../../../../core/services/user_profile_service.dart';
import '../../../../core/models/preparedness_item.dart';
import '../providers/home_provider.dart';
import '../widgets/readiness_card.dart';
import '../widgets/category_card.dart';
import '../widgets/next_step_item.dart';
import '../widgets/next_step_hero_card.dart';
import '../widgets/all_complete_card.dart';
import '../../../preparedness/presentation/screens/category_detail_screen.dart';
import '../../../settings/presentation/screens/settings_screen.dart';
import '../../../levels/screens/level_detail_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ItemsService _itemsService = ItemsService();
  final NextStepService _nextStepService = NextStepService();
  final UserProfileService _userProfileService = UserProfileService();
  bool _isSyncing = false;
  Map<String, double> progressByLevel = {
    '24h': 0.0,
    '72h': 0.0,
    '7d': 0.0,
  };
  Map<String, double> categoryProgress = {};
  List<PreparednessItem> nextSteps = [];
  NextStepRecommendation? nextStepRecommendation;
  bool isLoadingNextStep = true;
  UserProfile? userProfile;
  bool showHeroCard = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('HomeScreen: Loading data...');
      ref.read(homeProvider.notifier).loadData();
      _loadUserProfile();
      _loadProgress();
      _loadCategoryProgress();
      _loadNextSteps();
      _loadNextStepRecommendation();
    });
  }
  
  Future<void> _loadUserProfile() async {
    final profile = await _userProfileService.getUserProfile();
    final dismissed = await _userProfileService.isHeroCardDismissed();
    
    if (mounted) {
      setState(() {
        userProfile = profile;
        showHeroCard = !dismissed;
      });
    }
  }
  
  Future<void> _loadNextStepRecommendation() async {
    setState(() => isLoadingNextStep = true);
    
    final recommendation = await _nextStepService.getNextStep();
    
    if (mounted) {
      setState(() {
        nextStepRecommendation = recommendation;
        isLoadingNextStep = false;
      });
    }
  }
  
  Future<void> _loadProgress() async {
    final progress = await _itemsService.getProgressByLevel();
    
    if (mounted) {
      setState(() {
        progressByLevel = progress;
      });
    }
  }
  
  Future<void> _loadNextSteps() async {
    final steps = await _itemsService.getNextSteps(count: 5);
    
    if (mounted) {
      setState(() {
        nextSteps = steps;
      });
    }
  }
  
  Future<void> _loadCategoryProgress() async {
    print('\n=== LOADING CATEGORY PROGRESS ===');
    
    final allItems = await _itemsService.getAllItems();
    print('Total items loaded: ${allItems.length}');
    
    // Define valid categories (exclude "other")
    final validCategories = [
      'water',
      'food',
      'light',
      'heat',
      'radio',
      'cash',
      'medicine',
      'hygiene',
    ];
    
    print('Valid categories to load: $validCategories');
    
    final Map<String, double> progress = {};
    
    for (final category in validCategories) {
      print('\nCalculating progress for: "$category"');
      final categoryProgress = await _itemsService.getCategoryProgressAllLevels(category);
      progress[category] = categoryProgress;
      print('Result: $category = ${categoryProgress.toStringAsFixed(1)}%');
    }
    
    if (mounted) {
      setState(() {
        categoryProgress = progress;
      });
    }
    
    print('Final categoryProgress map: $categoryProgress');
    print('=== END LOADING CATEGORY PROGRESS ===\n');
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
      await _loadProgress();
      await _loadCategoryProgress();
      await _loadNextSteps();
      await _loadNextStepRecommendation();

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
                  onRefresh: () async {
                    await ref.read(homeProvider.notifier).loadData();
                    await _loadUserProfile();
                    await _loadProgress();
                    await _loadCategoryProgress();
                    await _loadNextSteps();
                    await _loadNextStepRecommendation();
                    await _userProfileService.triggerAutoSave('Refreshed home screen');
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // NEXT STEP HERO CARD (NEW - At the top!)
                        if (showHeroCard && isLoadingNextStep)
                          Container(
                            margin: const EdgeInsets.all(16),
                            height: 200,
                            child: const Center(child: CircularProgressIndicator()),
                          )
                        else if (showHeroCard && nextStepRecommendation != null)
                          NextStepHeroCard(
                            recommendation: nextStepRecommendation!,
                            onCompleted: () async {
                              await _loadProgress();
                              await _loadCategoryProgress();
                              await _loadNextSteps();
                              await _loadNextStepRecommendation();
                              ref.read(homeProvider.notifier).refreshProgress();
                            },
                            onDismissed: () {
                              setState(() {
                                showHeroCard = false;
                              });
                            },
                          )
                        else if (showHeroCard && !isLoadingNextStep)
                          const AllCompleteCard(),
                        
                        // Greeting
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            _getGreeting(context),
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            l10n.t('readiness_status'),
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.grey[600],
                                ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Readiness Overview
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                          children: [
                            Expanded(
                              child: ReadinessCard(
                                level: '24h',
                                percentage: progressByLevel['24h']!,
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LevelDetailScreen(level: '24h'),
                                    ),
                                  );
                                  if (mounted) {
                                    setState(() {});
                                    await _loadProgress();
                                    await _loadCategoryProgress();
                                    await _loadNextSteps();
                                    ref.read(homeProvider.notifier).refreshProgress();
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ReadinessCard(
                                level: '72h',
                                percentage: progressByLevel['72h']!,
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LevelDetailScreen(level: '72h'),
                                    ),
                                  );
                                  if (mounted) {
                                    setState(() {});
                                    await _loadProgress();
                                    await _loadCategoryProgress();
                                    await _loadNextSteps();
                                    ref.read(homeProvider.notifier).refreshProgress();
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ReadinessCard(
                                level: '7 dagar',
                                percentage: progressByLevel['7d']!,
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LevelDetailScreen(level: '7d'),
                                    ),
                                  );
                                  if (mounted) {
                                    setState(() {});
                                    await _loadProgress();
                                    await _loadCategoryProgress();
                                    await _loadNextSteps();
                                    ref.read(homeProvider.notifier).refreshProgress();
                                  }
                                },
                              ),
                            ),
                          ],
                          ),
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
                            final progress = categoryProgress[category.id] ?? 0.0;
                            return CategoryCard(
                              category: category,
                              progress: progress,
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryDetailScreen(
                                      categoryId: category.id,
                                    ),
                                  ),
                                );
                                // Refresh all data after returning - force immediate UI update
                                if (mounted) {
                                  setState(() {});
                                  await _loadProgress();
                                  await _loadCategoryProgress();
                                  await _loadNextSteps();
                                }
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
                        ] else if (nextSteps.isNotEmpty) ...[
                          // Kommande steg - show items based on hero card visibility
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Text(
                                  Localizations.localeOf(context).languageCode == 'en' 
                                    ? 'Next Steps' 
                                    : 'Kommande steg',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '${showHeroCard ? nextSteps.length - 1 : nextSteps.length}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: showHeroCard 
                              ? (nextSteps.length - 1).clamp(0, 4)
                              : nextSteps.length.clamp(0, 5),
                            separatorBuilder: (context, index) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              // If hero card is shown, skip first item; otherwise show all
                              final item = showHeroCard ? nextSteps[index + 1] : nextSteps[index];
                              return _buildNextStepCard(item);
                            },
                          ),
                        ] else ...[
                          // Empty state - all items completed!
                          Container(
                            padding: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFF4CAF50).withOpacity(0.3),
                              ),
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.check_circle_outline,
                                  size: 60,
                                  color: Color(0xFF4CAF50),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  '🎉 Allt klart!',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF4CAF50),
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Du har inga ofullständiga items just nu',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
    );
  }
  
  Widget _buildNextStepCard(PreparednessItem item) {
    return InkWell(
      onTap: () async {
        // Navigate to the category detail screen for this item
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryDetailScreen(
              categoryId: item.category,
            ),
          ),
        );
        // Reload after returning - force immediate UI update
        if (mounted) {
          setState(() {});
          await _loadProgress();
          await _loadCategoryProgress();
          await _loadNextSteps();
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Checkbox(
              value: item.isCompleted,
              onChanged: (value) async {
                // Toggle in unified database
                await _itemsService.toggleItemCompletion(item.id);
                // Reload all UI - force immediate update
                if (mounted) {
                  setState(() {});
                  await _loadProgress();
                  await _loadCategoryProgress();
                  await _loadNextSteps();
                }
              },
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _getCategoryColor(item.category).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _getCategoryIcon(item.category),
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.getName(Localizations.localeOf(context).languageCode),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getLevelColor(item.level).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item.level,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _getLevelColor(item.level),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${item.baseQuantity} ${item.unit}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
  
  Color _getCategoryColor(String category) {
    const colors = {
      'water': Color(0xFF2196F3),
      'food': Color(0xFF4CAF50),
      'light': Color(0xFFFF9800),
      'heat': Color(0xFFF44336),
      'radio': Color(0xFF9C27B0),
      'cash': Color(0xFF4CAF50),
      'medicine': Color(0xFFE91E63),
      'hygiene': Color(0xFF00BCD4),
      'first_aid': Color(0xFFE91E63),
      'other': Color(0xFF607D8B),
    };
    return colors[category] ?? const Color(0xFF2196F3);
  }
  
  String _getCategoryIcon(String category) {
    const icons = {
      'water': '💧',
      'food': '🍴',
      'light': '🔦',
      'heat': '🔥',
      'radio': '📻',
      'cash': '💵',
      'medicine': '💊',
      'hygiene': '🧼',
      'first_aid': '🏥',
      'other': '📦',
    };
    return icons[category] ?? '📦';
  }
  
  Color _getLevelColor(String level) {
    switch (level) {
      case '24h':
        return const Color(0xFF2196F3);
      case '72h':
        return const Color(0xFFFF9800);
      case '7d':
        return const Color(0xFF4CAF50);
      default:
        return const Color(0xFF2196F3);
    }
  }
}
