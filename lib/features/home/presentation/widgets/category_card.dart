import 'package:flutter/material.dart';
import '../../../../models/prep_category_model.dart';

class CategoryCard extends StatelessWidget {
  final PrepCategory category;
  final double progress;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.progress,
    required this.onTap,
  });

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'water_drop':
        return Icons.water_drop;
      case 'restaurant':
        return Icons.restaurant;
      case 'local_fire_department':
        return Icons.local_fire_department;
      case 'clean_hands':
        return Icons.clean_hands;
      case 'phone':
        return Icons.phone;
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

  Color _getProgressColor(double progress) {
    if (progress < 33) return Colors.red;
    if (progress < 67) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final progressColor = _getProgressColor(progress);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[300]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getIconData(category.icon),
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              category.name,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 4),
            Text(
              '${progress.toInt()}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: progressColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
