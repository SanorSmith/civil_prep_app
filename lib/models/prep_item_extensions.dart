import 'prep_item_model.dart';

extension PrepItemCalculations on PrepItem {
  /// Check if item is completed (current >= target)
  bool get isItemCompleted => currentQuantity >= targetQuantity;

  /// Calculate progress percentage (0-100)
  double get progressPercentage {
    if (targetQuantity == 0) return 0;
    final percentage = (currentQuantity / targetQuantity) * 100;
    return percentage.clamp(0, 100);
  }

  /// Get remaining quantity needed
  double get remainingQuantity {
    final remaining = targetQuantity - currentQuantity;
    return remaining > 0 ? remaining : 0;
  }
}
