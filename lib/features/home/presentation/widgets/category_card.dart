import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../models/prep_category_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/localization/app_localizations.dart';

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

  String _getCategoryName(BuildContext context, String categoryId) {
    final l10n = AppLocalizations.of(context);
    switch (categoryId) {
      case 'water':
        return l10n.t('water');
      case 'food':
        return l10n.t('food');
      case 'heating':
        return l10n.t('heat');
      case 'hygiene':
        return l10n.t('hygiene');
      case 'communication':
        return l10n.t('radio');
      case 'first_aid':
        return l10n.t('medicine');
      case 'lighting':
        return l10n.t('light');
      case 'documents':
        return l10n.t('cash');
      case 'cash':
        return l10n.t('cash');
      default:
        return category.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryColors = AppColors.getCategoryColors(category.id);
    final primaryColor = categoryColors['primary']!;
    final lightColor = categoryColors['light']!;
    final darkColor = categoryColors['dark']!;
    final progressColor = progress >= 100 ? AppColors.success : primaryColor;
    final isComplete = progress >= 100;

    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              lightColor.withOpacity(0.05),
              const Color(0xFF1E1E1E),
            ],
          ),
          border: Border.all(
            color: primaryColor.withOpacity(0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    primaryColor.withOpacity(0.3),
                    primaryColor.withOpacity(0.1),
                  ],
                ),
              ),
              child: Icon(
                _getIconData(category.icon),
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _getCategoryName(context, category.id),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Container(
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                boxShadow: isComplete
                    ? [
                        BoxShadow(
                          color: AppColors.success.withOpacity(0.5),
                          blurRadius: 8,
                        ),
                      ]
                    : null,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: progress / 100,
                  backgroundColor: const Color(0xFF2C2C2C),
                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${progress.toInt()}%',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                if (isComplete) ...[
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.check_circle,
                    size: 18,
                    color: AppColors.success,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
