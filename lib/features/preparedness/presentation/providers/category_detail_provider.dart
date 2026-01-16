import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/prep_item_model.dart';
import '../../../../models/prep_category_model.dart';
import '../../../preparedness/domain/services/progress_calculator.dart';

enum ItemFilter { all, completed, incomplete }
enum ItemSort { priority, alphabetical, status }

class CategoryDetailState {
  final PrepCategory? category;
  final List<PrepItem> items;
  final List<PrepItem> filteredItems;
  final ItemFilter filter;
  final ItemSort sort;
  final String selectedLevel;
  final double progress;
  final bool isLoading;
  final String? error;

  CategoryDetailState({
    this.category,
    this.items = const [],
    this.filteredItems = const [],
    this.filter = ItemFilter.all,
    this.sort = ItemSort.priority,
    this.selectedLevel = '24h',
    this.progress = 0.0,
    this.isLoading = false,
    this.error,
  });

  CategoryDetailState copyWith({
    PrepCategory? category,
    List<PrepItem>? items,
    List<PrepItem>? filteredItems,
    ItemFilter? filter,
    ItemSort? sort,
    String? selectedLevel,
    double? progress,
    bool? isLoading,
    String? error,
  }) {
    return CategoryDetailState(
      category: category ?? this.category,
      items: items ?? this.items,
      filteredItems: filteredItems ?? this.filteredItems,
      filter: filter ?? this.filter,
      sort: sort ?? this.sort,
      selectedLevel: selectedLevel ?? this.selectedLevel,
      progress: progress ?? this.progress,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class CategoryDetailNotifier extends StateNotifier<CategoryDetailState> {
  CategoryDetailNotifier(this.categoryId) : super(CategoryDetailState());

  final String categoryId;
  final _progressCalculator = ProgressCalculator();

  Future<void> loadItems(List<PrepItem> allItems) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final category = PrepCategory.getAllCategories()
          .firstWhere((cat) => cat.id == categoryId);

      final categoryItems = allItems
          .where((item) => item.categoryId == categoryId)
          .toList();

      final progress = _progressCalculator.calculateProgressForCategory(
        categoryId,
        allItems,
      );

      state = state.copyWith(
        category: category,
        items: categoryItems,
        filteredItems: categoryItems,
        progress: progress,
        isLoading: false,
      );

      _applyFilterAndSort();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void setFilter(ItemFilter filter) {
    state = state.copyWith(filter: filter);
    _applyFilterAndSort();
  }

  void setSort(ItemSort sort) {
    state = state.copyWith(sort: sort);
    _applyFilterAndSort();
  }

  void setLevel(String level) {
    state = state.copyWith(selectedLevel: level);
  }

  void _applyFilterAndSort() {
    var filtered = List<PrepItem>.from(state.items);

    // Apply filter
    switch (state.filter) {
      case ItemFilter.completed:
        filtered = filtered.where((item) => item.isCompleted).toList();
        break;
      case ItemFilter.incomplete:
        filtered = filtered.where((item) => !item.isCompleted).toList();
        break;
      case ItemFilter.all:
        break;
    }

    // Apply sort
    switch (state.sort) {
      case ItemSort.priority:
        filtered.sort((a, b) {
          if (a.isCustom != b.isCustom) {
            return a.isCustom ? 1 : -1;
          }
          return a.createdAt.compareTo(b.createdAt);
        });
        break;
      case ItemSort.alphabetical:
        filtered.sort((a, b) => a.name.compareTo(b.name));
        break;
      case ItemSort.status:
        filtered.sort((a, b) {
          if (a.isCompleted != b.isCompleted) {
            return a.isCompleted ? 1 : -1;
          }
          return a.name.compareTo(b.name);
        });
        break;
    }

    state = state.copyWith(filteredItems: filtered);
  }

  Future<void> updateItemQuantity(String itemId, double quantity) async {
    final itemIndex = state.items.indexWhere((item) => item.id == itemId);
    if (itemIndex == -1) return;

    final updatedItem = PrepItem.updateQuantity(
      existing: state.items[itemIndex],
      newQuantity: quantity,
    );

    final updatedItems = List<PrepItem>.from(state.items);
    updatedItems[itemIndex] = updatedItem;

    final progress = _progressCalculator.calculateProgressForCategory(
      categoryId,
      updatedItems,
    );

    state = state.copyWith(
      items: updatedItems,
      progress: progress,
    );

    _applyFilterAndSort();
  }

  Future<void> deleteItem(String itemId) async {
    final updatedItems = state.items.where((item) => item.id != itemId).toList();

    final progress = _progressCalculator.calculateProgressForCategory(
      categoryId,
      updatedItems,
    );

    state = state.copyWith(
      items: updatedItems,
      progress: progress,
    );

    _applyFilterAndSort();
  }
}

final categoryDetailProvider = StateNotifierProvider.family<
    CategoryDetailNotifier,
    CategoryDetailState,
    String>((ref, categoryId) {
  return CategoryDetailNotifier(categoryId);
});
