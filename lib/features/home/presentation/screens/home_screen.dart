import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/home_provider.dart';
import '../widgets/readiness_card.dart';
import '../widgets/category_card.dart';
import '../widgets/next_step_item.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('HomeScreen: Loading data...');
      ref.read(homeProvider.notifier).loadData();
    });
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'God morgon!';
    if (hour < 18) return 'God dag!';
    return 'God kväll!';
  }

  Color _getProgressColor(double progress) {
    if (progress < 33) return Colors.red;
    if (progress < 67) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Civil Beredskap'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings
            },
          ),
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              ref.read(homeProvider.notifier).refreshProgress();
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
                        child: const Text('Försök igen'),
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
                          _getGreeting(),
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Här är din beredskapsstatus',
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
                                color: _getProgressColor(homeState.progress24h),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ReadinessCard(
                                level: '72h',
                                percentage: homeState.progress72h,
                                color: _getProgressColor(homeState.progress72h),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ReadinessCard(
                                level: '7 dagar',
                                percentage: homeState.progress7d,
                                color: _getProgressColor(homeState.progress7d),
                              ),
                            ),
                          ],
                        ),
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
                                // Navigate to category detail
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 32),

                        // Next Steps Section
                        if (homeState.nextSteps.isNotEmpty) ...[
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
