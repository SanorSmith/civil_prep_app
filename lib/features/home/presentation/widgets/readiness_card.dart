import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/localization/app_localizations.dart';

class ReadinessCard extends StatelessWidget {
  final String level;
  final double percentage;
  final VoidCallback? onTap;

  const ReadinessCard({
    super.key,
    required this.level,
    required this.percentage,
    this.onTap,
  });

  Color get _progressColor {
    // Use specific colors for each level
    if (level == '24 timmar' || level == '24 hours' || level == '24h') {
      return const Color(0xFF4CAF50); // Green
    }
    if (level == '72 timmar' || level == '72 hours' || level == '72h') {
      return const Color(0xFFFF9800); // Orange
    }
    if (level == '7 dagar' || level == '7 days' || level == '7d') {
      return const Color(0xFF2196F3); // Blue
    }
    return AppColors.getProgressColor(percentage);
  }

  @override
  Widget build(BuildContext context) {
    final isComplete = percentage >= 100;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      value: percentage / 100,
                      strokeWidth: 8,
                      backgroundColor: AppColors.border,
                      valueColor: AlwaysStoppedAnimation<Color>(_progressColor),
                    ),
                  ),
                  if (isComplete)
                    Icon(
                      Icons.check_circle,
                      size: 48,
                      color: _progressColor,
                    )
                  else
                    Text(
                      '${percentage.toInt()}%',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: _progressColor,
                          ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              level,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              _getStatusText(context, percentage),
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        ),
      ),
    );
  }

  String _getStatusText(BuildContext context, double percentage) {
    final l10n = AppLocalizations.of(context);
    if (percentage == 0) return l10n.t('not_started');
    if (percentage < 25) return l10n.t('started');
    if (percentage < 50) return l10n.t('in_progress');
    if (percentage < 75) return l10n.t('good_progress');
    if (percentage < 100) return l10n.t('almost_done');
    return l10n.t('done');
  }
}
