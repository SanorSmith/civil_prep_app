import '../../../../models/prep_item_model.dart';
import '../../../../models/prep_item_extensions.dart';

class ProgressCalculator {
  /// Calculate overall progress for a specific level (24h, 72h, 7d)
  double calculateProgressForLevel(String level, List<PrepItem> allItems) {
    final levelItems = allItems.where((item) {
      // For now, all items contribute to all levels
      // In future, items can have essentialFor field
      return true;
    }).toList();

    if (levelItems.isEmpty) return 0.0;

    final completedCount = levelItems.where((item) => item.isItemCompleted).length;
    return (completedCount / levelItems.length) * 100;
  }

  /// Calculate progress for a specific category
  double calculateProgressForCategory(String categoryId, List<PrepItem> items) {
    final categoryItems = items.where((item) => item.categoryId == categoryId).toList();

    if (categoryItems.isEmpty) return 0.0;

    final completedCount = categoryItems.where((item) => item.isItemCompleted).length;
    return (completedCount / categoryItems.length) * 100;
  }

  /// Calculate progress for both level and category
  double calculateProgressForLevelAndCategory(
    String level,
    String categoryId,
    List<PrepItem> items,
  ) {
    final filteredItems = items.where((item) => item.categoryId == categoryId).toList();

    if (filteredItems.isEmpty) return 0.0;

    final completedCount = filteredItems.where((item) => item.isItemCompleted).length;
    return (completedCount / filteredItems.length) * 100;
  }

  /// Get next important steps (incomplete items sorted by priority)
  List<PrepItem> getNextSteps(List<PrepItem> allItems, int count) {
    final incompleteItems = allItems.where((item) => !item.isItemCompleted).toList();

    // Sort by: custom items last, then by creation date (oldest first)
    incompleteItems.sort((a, b) {
      if (a.isCustom != b.isCustom) {
        return a.isCustom ? 1 : -1; // Non-custom first
      }
      return a.createdAt.compareTo(b.createdAt); // Oldest first
    });

    return incompleteItems.take(count).toList();
  }

  /// Get category summary (map of categoryId to progress percentage)
  Map<String, double> getCategorySummary(List<PrepItem> items) {
    final summary = <String, double>{};
    final categories = items.map((item) => item.categoryId).toSet();

    for (final categoryId in categories) {
      summary[categoryId] = calculateProgressForCategory(categoryId, items);
    }

    return summary;
  }

  /// Get total items for a level
  int getTotalItemsForLevel(String level, List<PrepItem> items) {
    return items.length; // All items for now
  }

  /// Get completed items for a level
  int getCompletedItemsForLevel(String level, List<PrepItem> items) {
    return items.where((item) => item.isItemCompleted).length;
  }

  /// Check if an item is complete
  bool isItemComplete(PrepItem item) {
    return item.isItemCompleted;
  }

  /// Calculate priority score for an item (for sorting)
  double getItemPriorityScore(PrepItem item) {
    // Higher score = higher priority
    double score = 0;

    // Non-custom items have higher priority
    if (!item.isCustom) score += 100;

    // Items with more progress have lower priority (focus on starting items)
    score -= item.progressPercentage;

    // Older items have slightly higher priority
    final daysSinceCreation = DateTime.now().difference(item.createdAt).inDays;
    score += daysSinceCreation * 0.1;

    return score;
  }

  /// Calculate overall progress across all items
  double calculateOverallProgress(List<PrepItem> items) {
    if (items.isEmpty) return 0.0;

    final completedCount = items.where((item) => item.isItemCompleted).length;
    return (completedCount / items.length) * 100;
  }

  /// Get items by completion status
  List<PrepItem> getItemsByStatus(List<PrepItem> items, bool completed) {
    return items.where((item) => item.isItemCompleted == completed).toList();
  }

  /// Get statistics summary
  Map<String, dynamic> getStatistics(List<PrepItem> items) {
    final completed = items.where((item) => item.isItemCompleted).length;
    final total = items.length;
    final inProgress = items.where((item) => 
      item.currentQuantity > 0 && !item.isItemCompleted
    ).length;

    return {
      'total': total,
      'completed': completed,
      'inProgress': inProgress,
      'notStarted': total - completed - inProgress,
      'overallProgress': calculateOverallProgress(items),
    };
  }
}
