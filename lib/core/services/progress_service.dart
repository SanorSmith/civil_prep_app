import 'dart:convert';
import '../models/preparedness_item.dart';
import '../data/default_items.dart';
import 'storage_service.dart';

class ProgressService {
  Future<Map<String, double>> getProgressByLevel() async {
    final profile = await StorageService.getHouseholdProfile();
    if (profile == null) {
      return {'24h': 0.0, '72h': 0.0, '7d': 0.0};
    }
    
    final completedItemIds = await StorageService.getCompletedItemIds();
    
    final allItems = DefaultItems.getAll();
    
    final items24h = allItems.where((item) => item.level == '24h').toList();
    final items72h = allItems.where((item) => item.level == '72h').toList();
    final items7d = allItems.where((item) => item.level == '7d').toList();
    
    double progress24h = _calculateLevelProgress(items24h, completedItemIds);
    double progress72h = _calculateLevelProgress(items72h, completedItemIds);
    double progress7d = _calculateLevelProgress(items7d, completedItemIds);
    
    return {
      '24h': progress24h,
      '72h': progress72h,
      '7d': progress7d,
    };
  }
  
  double _calculateLevelProgress(
    List<PreparednessItem> levelItems,
    Set<String> completedItemIds,
  ) {
    if (levelItems.isEmpty) return 0.0;
    
    int completedCount = 0;
    
    for (var item in levelItems) {
      if (completedItemIds.contains(item.id)) {
        completedCount++;
      }
    }
    
    return (completedCount / levelItems.length) * 100.0;
  }
  
  Future<List<PreparednessItem>> getItemsForLevel(String level) async {
    final profile = await StorageService.getHouseholdProfile();
    if (profile == null) return [];
    
    final completedItemIds = await StorageService.getCompletedItemIds();
    
    List<PreparednessItem> items;
    
    switch (level) {
      case '24h':
        items = DefaultItems.get24hItems();
        break;
      case '72h':
        items = DefaultItems.get72hItems();
        break;
      case '7d':
        items = DefaultItems.get7dItems();
        break;
      default:
        items = [];
    }
    
    return items.map((item) {
      return item.copyWith(
        isCompleted: completedItemIds.contains(item.id),
      );
    }).toList();
  }
  
  Future<void> markItemComplete(String itemId) async {
    final completedIds = await StorageService.getCompletedItemIds();
    completedIds.add(itemId);
    await StorageService.saveCompletedItemIds(completedIds);
    
    await StorageService.saveItemCompletedAt(itemId, DateTime.now());
  }
  
  Future<void> markItemIncomplete(String itemId) async {
    final completedIds = await StorageService.getCompletedItemIds();
    completedIds.remove(itemId);
    await StorageService.saveCompletedItemIds(completedIds);
    
    await StorageService.removeItemCompletedAt(itemId);
  }
  
  Future<double> getCategoryProgress(String level, String category) async {
    final items = await getItemsForLevel(level);
    final categoryItems = items.where((item) => item.category == category).toList();
    
    if (categoryItems.isEmpty) return 0.0;
    
    int completedCount = categoryItems.where((item) => item.isCompleted).length;
    
    return (completedCount / categoryItems.length) * 100.0;
  }
  
}
