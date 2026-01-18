import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/preparedness_item.dart';
import '../data/default_items.dart';

/// SINGLE SOURCE OF TRUTH for all preparedness items
/// Used by:
/// - Home screen (progress indicators)
/// - Category screens (item lists)
/// - Recommendation system (next step)
/// - All other features
class ItemsService {
  static const String _itemsKey = 'all_preparedness_items';
  static const String _isInitializedKey = 'items_initialized';
  
  /// Get ALL items (default + custom)
  Future<List<PreparednessItem>> getAllItems() async {
    final prefs = await SharedPreferences.getInstance();
    
    // First time? Initialize with defaults
    if (!prefs.containsKey(_isInitializedKey)) {
      await _initializeDefaults();
    }
    
    final json = prefs.getString(_itemsKey);
    if (json == null) return [];
    
    final List<dynamic> list = jsonDecode(json);
    return list.map((item) => PreparednessItem.fromJson(item)).toList();
  }
  
  /// Get items filtered by level
  Future<List<PreparednessItem>> getItemsByLevel(String level) async {
    final allItems = await getAllItems();
    return allItems.where((item) => item.level == level).toList();
  }
  
  /// Get items filtered by level AND category
  Future<List<PreparednessItem>> getItemsByLevelAndCategory({
    required String level,
    required String category,
  }) async {
    final allItems = await getAllItems();
    return allItems.where((item) => 
      item.level == level && item.category == category
    ).toList();
  }
  
  /// Update item completion status
  Future<void> toggleItemCompletion(String itemId) async {
    final items = await getAllItems();
    
    final index = items.indexWhere((item) => item.id == itemId);
    if (index == -1) return;
    
    final item = items[index];
    items[index] = item.copyWith(
      isCompleted: !item.isCompleted,
      completedAt: !item.isCompleted ? DateTime.now() : null,
    );
    
    await _saveAllItems(items);
  }
  
  /// Add custom item with bilingual support
  Future<void> addCustomItem({
    required String level,
    required String category,
    required String name,
    required String description,
    required int quantity,
    required String unit,
  }) async {
    final items = await getAllItems();
    
    final newItem = PreparednessItem(
      id: PreparednessItem.generateId(
        level: level,
        category: category,
        customSuffix: 'custom',
      ),
      level: level,
      category: category,
      nameSv: name,  // User enters Swedish
      nameEn: name,  // Same text for both (can be edited later)
      descriptionSv: description,
      descriptionEn: description,
      baseQuantity: quantity,
      unit: unit,
      isCustom: true,
    );
    
    items.add(newItem);
    await _saveAllItems(items);
  }
  
  /// Delete custom item
  Future<void> deleteCustomItem(String itemId) async {
    final items = await getAllItems();
    items.removeWhere((item) => item.id == itemId && item.isCustom);
    await _saveAllItems(items);
  }
  
  /// Get progress for each level
  Future<Map<String, double>> getProgressByLevel() async {
    final allItems = await getAllItems();
    
    final items24h = allItems.where((item) => item.level == '24h').toList();
    final items72h = allItems.where((item) => item.level == '72h').toList();
    final items7d = allItems.where((item) => item.level == '7d').toList();
    
    return {
      '24h': _calculateProgress(items24h),
      '72h': _calculateProgress(items72h),
      '7d': _calculateProgress(items7d),
    };
  }
  
  /// Get progress for specific category within level
  Future<double> getCategoryProgress({
    required String level,
    required String category,
  }) async {
    final items = await getItemsByLevelAndCategory(
      level: level,
      category: category,
    );
    
    return _calculateProgress(items);
  }
  
  /// Get progress for specific category across ALL levels (for category cards)
  Future<double> getCategoryProgressAllLevels(String category) async {
    print('=== DIAGNOSTIC: getCategoryProgressAllLevels called ===');
    print('Looking for category: "$category"');
    
    final allItems = await getAllItems();
    print('Total items in database: ${allItems.length}');
    
    // Show all unique categories in database
    final uniqueCategories = allItems.map((item) => item.category).toSet();
    print('Unique categories in database: $uniqueCategories');
    
    // Filter items for this category
    final categoryItems = allItems.where((item) {
      final matches = item.category == category;
      if (matches) {
        print('  Found item: ${item.nameSv} (category: ${item.category}, completed: ${item.isCompleted})');
      }
      return matches;
    }).toList();
    
    print('Items found for "$category": ${categoryItems.length}');
    
    if (categoryItems.isEmpty) {
      print('WARNING: No items found for category "$category"!');
      print('Available categories: $uniqueCategories');
      return 0.0;
    }
    
    final completed = categoryItems.where((item) => item.isCompleted).length;
    final progress = (completed / categoryItems.length) * 100.0;
    
    print('Progress for "$category": $completed/${categoryItems.length} = ${progress.toStringAsFixed(1)}%');
    print('=== END DIAGNOSTIC ===\n');
    
    return progress;
  }
  
  /// Calculate progress percentage
  double _calculateProgress(List<PreparednessItem> items) {
    if (items.isEmpty) return 0.0;
    
    final completed = items.where((item) => item.isCompleted).length;
    return (completed / items.length) * 100.0;
  }
  
  /// Initialize with default items (first time only)
  Future<void> _initializeDefaults() async {
    final defaultItems = DefaultItems.getAll();
    await _saveAllItems(defaultItems);
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isInitializedKey, true);
  }
  
  /// Save all items to storage
  Future<void> _saveAllItems(List<PreparednessItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(items.map((item) => item.toJson()).toList());
    await prefs.setString(_itemsKey, json);
  }
  
  /// Get next important steps with smart prioritization
  Future<List<PreparednessItem>> getNextSteps({int count = 5}) async {
    final allItems = await getAllItems();
    
    print('\n=== DEBUG: GET NEXT STEPS ===');
    print('Total items in database: ${allItems.length}');
    
    // Show first few items with their categories
    print('\nSample items (first 5):');
    for (var i = 0; i < allItems.length && i < 5; i++) {
      final item = allItems[i];
      print('  ${i + 1}. "${item.nameSv}" - Category: "${item.category}", Level: ${item.level}, Completed: ${item.isCompleted}');
    }
    
    // Filter to only incomplete items
    final incompleteItems = allItems
      .where((item) => !item.isCompleted)
      .toList();
    
    print('\nUncompleted items: ${incompleteItems.length}');
    if (incompleteItems.isNotEmpty) {
      print('First 3 uncompleted items:');
      for (var i = 0; i < incompleteItems.length && i < 3; i++) {
        final item = incompleteItems[i];
        print('  - "${item.nameSv}" (${item.category}, ${item.level})');
      }
    }
    
    if (incompleteItems.isEmpty) {
      print('No uncompleted items found!');
      print('=== END DEBUG ===\n');
      return [];
    }
    
    // Sort by priority
    incompleteItems.sort((a, b) {
      // Priority 1: Level (24h > 72h > 7d)
      final levelPriorityA = _getLevelPriority(a.level);
      final levelPriorityB = _getLevelPriority(b.level);
      
      if (levelPriorityA != levelPriorityB) {
        return levelPriorityB.compareTo(levelPriorityA); // Higher first
      }
      
      // Priority 2: Category importance
      final categoryPriorityA = _getCategoryPriority(a.category);
      final categoryPriorityB = _getCategoryPriority(b.category);
      
      if (categoryPriorityA != categoryPriorityB) {
        return categoryPriorityB.compareTo(categoryPriorityA); // Higher first
      }
      
      // Priority 3: Default items before custom items
      if (a.isCustom != b.isCustom) {
        return a.isCustom ? 1 : -1;
      }
      
      // Priority 4: Alphabetical by name
      return a.name.compareTo(b.name);
    });
    
    // Return top N items
    final topItems = incompleteItems.take(count).toList();
    
    print('\nReturning top ${topItems.length} items:');
    for (var i = 0; i < topItems.length; i++) {
      final item = topItems[i];
      print('  ${i + 1}. "${item.nameSv}" (${item.category}, ${item.level})');
    }
    print('=== END DEBUG ===\n');
    
    return topItems;
  }
  
  /// Get priority score for level (higher = more important)
  int _getLevelPriority(String level) {
    switch (level) {
      case '24h':
        return 100; // Most important
      case '72h':
        return 50;  // Medium importance
      case '7d':
        return 25;  // Least urgent
      default:
        return 0;
    }
  }
  
  /// Get priority score for category (higher = more important)
  int _getCategoryPriority(String category) {
    const priorities = {
      'water': 100,      // Most critical - can't survive 3 days without
      'food': 90,        // Very important - can't survive 7 days without
      'light': 80,       // Safety critical - needed for navigation
      'radio': 75,       // Information critical
      'medicine': 70,    // Health critical
      'cash': 65,        // Important - cards may not work
      'first_aid': 60,   // Medical emergency preparedness
      'hygiene': 50,     // Health and comfort
      'heat': 45,        // Important in winter, less urgent otherwise
    };
    
    return priorities[category] ?? 25; // Default low priority for unknown
  }
  
  /// Reset all items (for testing or user request)
  Future<void> resetAllItems() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_itemsKey);
    await prefs.remove(_isInitializedKey);
    await _initializeDefaults();
  }
}
