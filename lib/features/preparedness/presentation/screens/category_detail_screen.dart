import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/prep_category_model.dart';
import '../providers/category_detail_provider.dart';
import '../widgets/prep_item_card.dart';
import '../../../home/presentation/providers/home_provider.dart';

class CategoryDetailScreen extends ConsumerStatefulWidget {
  final String categoryId;

  const CategoryDetailScreen({
    super.key,
    required this.categoryId,
  });

  @override
  ConsumerState<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends ConsumerState<CategoryDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final homeState = ref.read(homeProvider);
      ref.read(categoryDetailProvider(widget.categoryId).notifier)
          .loadItems(homeState.items);
    });
  }

  IconData _getCategoryIcon(String iconName) {
    switch (iconName) {
      case 'water_drop':
        return Icons.water_drop;
      case 'restaurant':
        return Icons.restaurant;
      case 'local_fire_department':
        return Icons.local_fire_department;
      case 'clean_hands':
        return Icons.clean_hands;
      case 'radio':
        return Icons.radio;
      case 'medical_services':
        return Icons.medical_services;
      case 'lightbulb':
        return Icons.lightbulb;
      case 'description':
        return Icons.description;
      case 'payments':
        return Icons.payments;
      default:
        return Icons.more_horiz;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtrera'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Alla'),
              leading: Radio<ItemFilter>(
                value: ItemFilter.all,
                groupValue: ref.read(categoryDetailProvider(widget.categoryId)).filter,
                onChanged: (value) {
                  if (value != null) {
                    ref.read(categoryDetailProvider(widget.categoryId).notifier)
                        .setFilter(value);
                    Navigator.pop(context);
                  }
                },
              ),
            ),
            ListTile(
              title: const Text('Klara'),
              leading: Radio<ItemFilter>(
                value: ItemFilter.completed,
                groupValue: ref.read(categoryDetailProvider(widget.categoryId)).filter,
                onChanged: (value) {
                  if (value != null) {
                    ref.read(categoryDetailProvider(widget.categoryId).notifier)
                        .setFilter(value);
                    Navigator.pop(context);
                  }
                },
              ),
            ),
            ListTile(
              title: const Text('Ej klara'),
              leading: Radio<ItemFilter>(
                value: ItemFilter.incomplete,
                groupValue: ref.read(categoryDetailProvider(widget.categoryId)).filter,
                onChanged: (value) {
                  if (value != null) {
                    ref.read(categoryDetailProvider(widget.categoryId).notifier)
                        .setFilter(value);
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSortDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sortera'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Prioritet'),
              leading: Radio<ItemSort>(
                value: ItemSort.priority,
                groupValue: ref.read(categoryDetailProvider(widget.categoryId)).sort,
                onChanged: (value) {
                  if (value != null) {
                    ref.read(categoryDetailProvider(widget.categoryId).notifier)
                        .setSort(value);
                    Navigator.pop(context);
                  }
                },
              ),
            ),
            ListTile(
              title: const Text('Alfabetisk'),
              leading: Radio<ItemSort>(
                value: ItemSort.alphabetical,
                groupValue: ref.read(categoryDetailProvider(widget.categoryId)).sort,
                onChanged: (value) {
                  if (value != null) {
                    ref.read(categoryDetailProvider(widget.categoryId).notifier)
                        .setSort(value);
                    Navigator.pop(context);
                  }
                },
              ),
            ),
            ListTile(
              title: const Text('Status'),
              leading: Radio<ItemSort>(
                value: ItemSort.status,
                groupValue: ref.read(categoryDetailProvider(widget.categoryId)).sort,
                onChanged: (value) {
                  if (value != null) {
                    ref.read(categoryDetailProvider(widget.categoryId).notifier)
                        .setSort(value);
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoryDetailProvider(widget.categoryId));

    if (state.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.error != null) {
      return Scaffold(
        body: Center(
          child: Text('Error: ${state.error}'),
        ),
      );
    }

    final category = state.category;
    if (category == null) {
      return const Scaffold(
        body: Center(child: Text('Category not found')),
      );
    }

    final completedCount = state.items.where((item) => item.isCompleted).length;
    final totalCount = state.items.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _showSortDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            child: Column(
              children: [
                Icon(
                  _getCategoryIcon(category.icon),
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 12),
                Text(
                  '$completedCount av $totalCount klart',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: state.progress / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 8),
                Text(
                  '${state.progress.toInt()}%',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: '24h', label: Text('24h')),
                      ButtonSegment(value: '72h', label: Text('72h')),
                      ButtonSegment(value: '7d', label: Text('7 dagar')),
                    ],
                    selected: {state.selectedLevel},
                    onSelectionChanged: (Set<String> selected) {
                      ref.read(categoryDetailProvider(widget.categoryId).notifier)
                          .setLevel(selected.first);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: state.filteredItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Inga artiklar hittades',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = state.filteredItems[index];
                      return PrepItemCard(
                        item: item,
                        onQuantityChanged: (quantity) {
                          ref.read(categoryDetailProvider(widget.categoryId).notifier)
                              .updateItemQuantity(item.id, quantity);
                        },
                        onDelete: item.isCustom
                            ? () {
                                ref.read(categoryDetailProvider(widget.categoryId).notifier)
                                    .deleteItem(item.id);
                              }
                            : null,
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add custom item dialog
        },
        icon: const Icon(Icons.add),
        label: const Text('Lägg till egen'),
      ),
    );
  }
}
