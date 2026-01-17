import 'package:flutter/material.dart';
import '../../../../models/prep_item_model.dart';

class NextStepItem extends StatelessWidget {
  final PrepItem item;
  final VoidCallback onTap;
  final Function(bool?) onCheckChanged;

  const NextStepItem({
    super.key,
    required this.item,
    required this.onTap,
    required this.onCheckChanged,
  });

  IconData _getCategoryIcon(String categoryId) {
    switch (categoryId) {
      case 'water':
        return Icons.water_drop;
      case 'food':
        return Icons.restaurant;
      case 'heating':
        return Icons.local_fire_department;
      case 'hygiene':
        return Icons.clean_hands;
      case 'communication':
        return Icons.radio;
      case 'first_aid':
        return Icons.medical_services;
      case 'lighting':
        return Icons.lightbulb;
      case 'documents':
        return Icons.description;
      case 'cash':
        return Icons.payments;
      default:
        return Icons.check_box_outline_blank;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
              onChanged: onCheckChanged,
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getCategoryIcon(item.categoryId),
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.targetQuantity.toInt()} ${item.unit}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
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
}
