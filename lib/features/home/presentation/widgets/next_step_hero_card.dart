import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/services/next_step_service.dart';
import '../../../../core/services/items_service.dart';
import '../../../../core/services/user_profile_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../preparedness/presentation/screens/category_detail_screen.dart';

class NextStepHeroCard extends StatelessWidget {
  final NextStepRecommendation recommendation;
  final VoidCallback onCompleted;
  final VoidCallback onDismissed;
  
  const NextStepHeroCard({
    Key? key,
    required this.recommendation,
    required this.onCompleted,
    required this.onDismissed,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final item = recommendation.item;
    final languageCode = Localizations.localeOf(context).languageCode;
    
    final actionTitle = recommendation.getActionTitle(languageCode);
    final whyImportant = recommendation.getWhyImportant(languageCode);
    final howToComplete = recommendation.getHowToComplete(languageCode);
    final tips = recommendation.getTips(languageCode);
    
    final labels = _getLabels(languageCode);
    
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getCategoryColor(item.category),
            _getCategoryColor(item.category).withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _getCategoryColor(item.category).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.flag, color: Colors.white, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          labels['header']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Text(
                    actionTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _getCategoryIcon(item.category),
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${item.baseQuantity} ${item.unit}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            item.level,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  _buildExpandableSection(
                    context,
                    labels['whyTitle']!,
                    Icons.info_outline,
                    whyImportant,
                  ),
                  
                  const SizedBox(height: 12),
                  
                  _buildExpandableSection(
                    context,
                    labels['howTitle']!,
                    Icons.checklist,
                    howToComplete,
                  ),
                  
                  const SizedBox(height: 12),
                  
                  _buildTipsSection(context, labels['tipsTitle']!, tips),
                  
                  const SizedBox(height: 24),
                  
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ElevatedButton.icon(
                          onPressed: () => _navigateToCategory(context),
                          icon: const Icon(Icons.arrow_forward),
                          label: Text(labels['goButton']!),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: _getCategoryColor(item.category),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _markComplete(context),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white, width: 2),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(labels['doneButton']!),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                onPressed: () => _dismissHeroCard(context),
                icon: const Icon(Icons.close, color: Colors.white),
                tooltip: labels['closeButton'],
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Map<String, String> _getLabels(String languageCode) {
    if (languageCode == 'en') {
      return {
        'header': 'YOUR NEXT ACTION',
        'whyTitle': 'Why is this important?',
        'howTitle': 'How do I complete this?',
        'tipsTitle': 'Tips & advice',
        'goButton': 'Take me there',
        'doneButton': 'Done',
        'closeButton': 'Close',
        'celebrationTitle': 'Well done!',
        'celebrationMessage': 'You have completed:',
        'continueButton': 'Continue',
        'dismissConfirmTitle': 'Hide recommendation?',
        'dismissConfirmMessage': 'You can show it again from settings.',
        'dismissConfirmYes': 'Hide',
        'dismissConfirmNo': 'Cancel',
      };
    } else {
      return {
        'header': 'DIN NÄSTA ÅTGÄRD',
        'whyTitle': 'Varför är detta viktigt?',
        'howTitle': 'Hur genomför jag detta?',
        'tipsTitle': 'Tips & råd',
        'goButton': 'Ta mig dit',
        'doneButton': 'Klart',
        'closeButton': 'Stäng',
        'celebrationTitle': 'Bra jobbat!',
        'celebrationMessage': 'Du har slutfört:',
        'continueButton': 'Fortsätt',
        'dismissConfirmTitle': 'Dölj rekommendation?',
        'dismissConfirmMessage': 'Du kan visa den igen från inställningar.',
        'dismissConfirmYes': 'Dölj',
        'dismissConfirmNo': 'Avbryt',
      };
    }
  }
  
  Widget _buildExpandableSection(
    BuildContext context,
    String title,
    IconData icon,
    String content,
  ) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 28, right: 16, bottom: 12),
            child: Text(
              content,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTipsSection(BuildContext context, String title, List<String> tips) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Row(
          children: [
            const Icon(Icons.lightbulb_outline, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 28, right: 16, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: tips.map((tip) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '• ',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          tip,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
  
  void _navigateToCategory(BuildContext context) async {
    final userProfileService = UserProfileService();
    await userProfileService.triggerAutoSave('Navigate to category ${recommendation.item.category}');
    
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryDetailScreen(
          categoryId: recommendation.item.category,
        ),
      ),
    );
    
    onCompleted();
  }
  
  void _markComplete(BuildContext context) async {
    HapticFeedback.heavyImpact();
    
    final itemsService = ItemsService();
    await itemsService.toggleItemCompletion(recommendation.item.id);
    
    final userProfileService = UserProfileService();
    await userProfileService.triggerAutoSave('Completed item ${recommendation.item.id}');
    
    _showCelebrationDialog(context);
  }
  
  void _dismissHeroCard(BuildContext context) async {
    final languageCode = Localizations.localeOf(context).languageCode;
    final labels = _getLabels(languageCode);
    
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(labels['dismissConfirmTitle']!),
        content: Text(labels['dismissConfirmMessage']!),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(labels['dismissConfirmNo']!),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(labels['dismissConfirmYes']!),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      final userProfileService = UserProfileService();
      await userProfileService.dismissHeroCard();
      await userProfileService.triggerAutoSave('Dismissed hero card');
      
      onDismissed();
    }
  }
  
  void _showCelebrationDialog(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final labels = _getLabels(languageCode);
    final actionTitle = recommendation.getActionTitle(languageCode);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.celebration,
              size: 64,
              color: Color(0xFF4CAF50),
            ),
            const SizedBox(height: 16),
            Text(
              labels['celebrationTitle']!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${labels['celebrationMessage']!}\n$actionTitle',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onCompleted();
            },
            child: Text(labels['continueButton']!),
          ),
        ],
      ),
    );
  }
  
  Color _getCategoryColor(String category) {
    const colors = {
      'water': Color(0xFF2196F3),
      'food': Color(0xFF4CAF50),
      'light': Color(0xFFFF9800),
      'heat': Color(0xFFF44336),
      'radio': Color(0xFF9C27B0),
      'cash': Color(0xFF4CAF50),
      'medicine': Color(0xFFE91E63),
      'hygiene': Color(0xFF00BCD4),
    };
    return colors[category] ?? const Color(0xFF2196F3);
  }
  
  String _getCategoryIcon(String category) {
    const icons = {
      'water': '💧',
      'food': '🍴',
      'light': '🔦',
      'heat': '🔥',
      'radio': '📻',
      'cash': '💵',
      'medicine': '💊',
      'hygiene': '🧼',
    };
    return icons[category] ?? '📦';
  }
}
