import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../models/household_profile_model.dart';
import '../../../../models/prep_item_model.dart';
import '../../../../models/prep_category_model.dart';
import '../../../../models/user_model.dart';
import '../../../preparedness/domain/services/preparedness_calculator.dart';
import '../../../preparedness/domain/services/progress_calculator.dart';

class HomeState {
  final HouseholdProfile? profile;
  final List<PrepItem> items;
  final List<PrepCategory> categories;
  final Map<String, double> categoryProgress;
  final double progress24h;
  final double progress72h;
  final double progress7d;
  final List<PrepItem> nextSteps;
  final bool isLoading;
  final String? error;

  HomeState({
    this.profile,
    this.items = const [],
    this.categories = const [],
    this.categoryProgress = const {},
    this.progress24h = 0.0,
    this.progress72h = 0.0,
    this.progress7d = 0.0,
    this.nextSteps = const [],
    this.isLoading = false,
    this.error,
  });

  HomeState copyWith({
    HouseholdProfile? profile,
    List<PrepItem>? items,
    List<PrepCategory>? categories,
    Map<String, double>? categoryProgress,
    double? progress24h,
    double? progress72h,
    double? progress7d,
    List<PrepItem>? nextSteps,
    bool? isLoading,
    String? error,
  }) {
    return HomeState(
      profile: profile ?? this.profile,
      items: items ?? this.items,
      categories: categories ?? this.categories,
      categoryProgress: categoryProgress ?? this.categoryProgress,
      progress24h: progress24h ?? this.progress24h,
      progress72h: progress72h ?? this.progress72h,
      progress7d: progress7d ?? this.progress7d,
      nextSteps: nextSteps ?? this.nextSteps,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(HomeState());

  final _prepCalculator = PreparednessCalculator();
  final _progressCalculator = ProgressCalculator();

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Try to load from Hive first
      final userBox = await Hive.openBox<User>('users');
      if (userBox.isNotEmpty) {
        final user = userBox.values.first;
        await loadDataFromHive(user.id);
      } else {
        // Fallback to mock data if no user exists
        await _generateMockData();
      }

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> loadDataFromHive(String userId) async {
    try {
      // Load profile
      final profileBox = await Hive.openBox<HouseholdProfile>('household_profiles');
      final profile = profileBox.values.firstWhere(
        (p) => p.userId == userId,
        orElse: () => throw Exception('Profile not found'),
      );

      // Load items
      final itemsBox = await Hive.openBox('prep_items');
      final items = itemsBox.values
          .whereType<PrepItem>()
          .where((item) => item.userId == userId)
          .toList();

      // Generate categories
      final categories = _prepCalculator.generateCategories();

      // Calculate progress
      final progress24h = _progressCalculator.calculateProgressForLevel('24h', items);
      final progress72h = _progressCalculator.calculateProgressForLevel('72h', items);
      final progress7d = _progressCalculator.calculateProgressForLevel('7d', items);

      // Get category progress
      final categoryProgress = _progressCalculator.getCategorySummary(items);

      // Get next steps
      final nextSteps = _progressCalculator.getNextSteps(items, 3);

      state = state.copyWith(
        profile: profile,
        items: items,
        categories: categories,
        categoryProgress: categoryProgress,
        progress24h: progress24h,
        progress72h: progress72h,
        progress7d: progress7d,
        nextSteps: nextSteps,
      );
    } catch (e) {
      print('Error loading from Hive: $e');
      rethrow;
    }
  }

  Future<void> _generateMockData() async {
    try {
      // Create mock profile
      final profile = HouseholdProfile.create(
        userId: 'mock-user',
        postalCode: '11522',
        housingType: HousingType.apartment,
        heatingType: HeatingType.electric,
        adultCount: 2,
        childCount: 1,
      );

      // Generate categories
      final categories = _prepCalculator.generateCategories();

      // Generate items
      final items = _prepCalculator.calculateRequirements(
        profile: profile,
        userId: 'mock-user',
      );

      // Calculate progress
      final progress24h = _progressCalculator.calculateProgressForLevel('24h', items);
      final progress72h = _progressCalculator.calculateProgressForLevel('72h', items);
      final progress7d = _progressCalculator.calculateProgressForLevel('7d', items);

      // Get category progress
      final categoryProgress = _progressCalculator.getCategorySummary(items);

      // Get next steps
      final nextSteps = _progressCalculator.getNextSteps(items, 3);

      state = state.copyWith(
        profile: profile,
        items: items,
        categories: categories,
        categoryProgress: categoryProgress,
        progress24h: progress24h,
        progress72h: progress72h,
        progress7d: progress7d,
        nextSteps: nextSteps,
      );
    } catch (e) {
      print('Error generating mock data: $e');
      rethrow;
    }
  }

  Future<void> refreshProgress() async {
    if (state.items.isEmpty) return;

    final progress24h = _progressCalculator.calculateProgressForLevel('24h', state.items);
    final progress72h = _progressCalculator.calculateProgressForLevel('72h', state.items);
    final progress7d = _progressCalculator.calculateProgressForLevel('7d', state.items);
    final categoryProgress = _progressCalculator.getCategorySummary(state.items);
    final nextSteps = _progressCalculator.getNextSteps(state.items, 3);

    state = state.copyWith(
      progress24h: progress24h,
      progress72h: progress72h,
      progress7d: progress7d,
      categoryProgress: categoryProgress,
      nextSteps: nextSteps,
    );
  }

  Future<void> markItemComplete(String itemId, bool completed) async {
    final itemIndex = state.items.indexWhere((item) => item.id == itemId);
    if (itemIndex == -1) return;

    final updatedItem = PrepItem.markComplete(
      existing: state.items[itemIndex],
      completed: completed,
    );

    final updatedItems = List<PrepItem>.from(state.items);
    updatedItems[itemIndex] = updatedItem;

    // Save to Hive
    try {
      final itemsBox = await Hive.openBox('prep_items');
      await itemsBox.put(updatedItem.id, updatedItem);
    } catch (e) {
      print('Error saving item to Hive: $e');
    }

    state = state.copyWith(items: updatedItems);
    await refreshProgress();
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

    // Save to Hive
    try {
      final itemsBox = await Hive.openBox('prep_items');
      await itemsBox.put(updatedItem.id, updatedItem);
    } catch (e) {
      print('Error saving item to Hive: $e');
    }

    state = state.copyWith(items: updatedItems);
    await refreshProgress();
  }
}

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});
