import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/services/items_service.dart';
import '../../../core/models/preparedness_item.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/add_custom_item_dialog.dart';

class LevelDetailScreen extends StatefulWidget {
  final String level;
  
  const LevelDetailScreen({Key? key, required this.level}) : super(key: key);
  
  @override
  State<LevelDetailScreen> createState() => _LevelDetailScreenState();
}

class _LevelDetailScreenState extends State<LevelDetailScreen> {
  final ItemsService _itemsService = ItemsService();
  
  List<PreparednessItem> items = [];
  bool isLoading = true;
  double progress = 0.0;
  Map<String, List<PreparednessItem>> itemsByCategory = {};
  
  @override
  void initState() {
    super.initState();
    _loadItems();
  }
  
  Future<void> _loadItems() async {
    setState(() => isLoading = true);
    
    final levelItems = await _itemsService.getItemsByLevel(widget.level);
    final progressMap = await _itemsService.getProgressByLevel();
    
    // Group items by category
    final grouped = <String, List<PreparednessItem>>{};
    for (var item in levelItems) {
      if (!grouped.containsKey(item.category)) {
        grouped[item.category] = [];
      }
      grouped[item.category]!.add(item);
    }
    
    if (mounted) {
      setState(() {
        items = levelItems;
        itemsByCategory = grouped;
        progress = progressMap[widget.level] ?? 0.0;
        isLoading = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor(context),
      appBar: AppBar(
        title: Text('${widget.level} ${l10n.t('preparedness')}'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                '${progress.toInt()}%',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _getColorForProgress(progress),
                ),
              ),
            ),
          ),
        ],
      ),
      body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildProgressOverview(),
              const SizedBox(height: 24),
              ...itemsByCategory.entries.map((entry) {
                return _buildCategorySection(entry.key, entry.value);
              }).toList(),
            ],
          ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddCustomItemDialog,
        icon: const Icon(Icons.add),
        label: Text(
          Localizations.localeOf(context).languageCode == 'en' 
            ? 'Add custom' 
            : 'Lägg till egen',
        ),
        backgroundColor: _getLevelColor(),
      ),
    );
  }
  
  Future<void> _showAddCustomItemDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AddCustomItemDialog(
        initialLevel: widget.level,
      ),
    );
    
    if (result == true) {
      await _loadItems();
    }
  }
  
  Widget _buildProgressOverview() {
    final totalItems = items.length;
    final completedItems = items.where((item) => item.isCompleted).length;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor(context)),
      ),
      child: Column(
        children: [
          Text(
            '$completedItems av $totalItems klart',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary(context),
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: totalItems > 0 ? completedItems / totalItems : 0,
              minHeight: 12,
              backgroundColor: AppTheme.borderColor(context),
              valueColor: AlwaysStoppedAnimation(_getLevelColor()),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategorySection(String category, List<PreparednessItem> categoryItems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Text(
                _getCategoryIcon(category),
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 12),
              Text(
                _getCategoryName(category),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary(context),
                ),
              ),
            ],
          ),
        ),
        ...categoryItems.map((item) => _buildItemCard(item)).toList(),
        const SizedBox(height: 16),
      ],
    );
  }
  
  Widget _buildItemCard(PreparednessItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: item.isCompleted 
            ? _getLevelColor().withOpacity(0.5)
            : AppTheme.borderColor(context),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _toggleItem(item),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Checkbox(
                  value: item.isCompleted,
                  onChanged: (_) => _toggleItem(item),
                  activeColor: _getLevelColor(),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getCategoryColor(item.category).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      _getCategoryIcon(item.category),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.getName(Localizations.localeOf(context).languageCode),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: item.isCompleted 
                            ? TextDecoration.lineThrough 
                            : null,
                          color: AppTheme.textPrimary(context),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.getDescription(Localizations.localeOf(context).languageCode),
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary(context),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${item.baseQuantity} ${item.unit}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getCategoryColor(item.category),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Future<void> _toggleItem(PreparednessItem item) async {
    HapticFeedback.mediumImpact();
    
    await _itemsService.toggleItemCompletion(item.id);
    await _loadItems();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${item.getName(Localizations.localeOf(context).languageCode)} ${!item.isCompleted ? "klar" : "ofullständig"}!',
          ),
          backgroundColor: !item.isCompleted 
            ? const Color(0xFF4CAF50) 
            : const Color(0xFFFF9800),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
  
  Color _getLevelColor() {
    switch (widget.level) {
      case '24h':
        return const Color(0xFF2196F3);
      case '72h':
        return const Color(0xFFFF9800);
      case '7d':
        return const Color(0xFF4CAF50);
      default:
        return const Color(0xFF2196F3);
    }
  }
  
  String _getCategoryName(String category) {
    const names = {
      'water': 'Vatten',
      'food': 'Mat',
      'light': 'Ljus',
      'heat': 'Värme',
      'radio': 'Radio',
      'cash': 'Kontanter',
      'medicine': 'Medicin',
      'hygiene': 'Hygien',
      'first_aid': 'Första hjälpen',
      'other': 'Övrigt',
    };
    return names[category] ?? category;
  }
  
  Color _getColorForProgress(double progress) {
    if (progress >= 75) return const Color(0xFF4CAF50);
    if (progress >= 50) return const Color(0xFFFF9800);
    if (progress > 0) return const Color(0xFFF44336);
    return Colors.grey;
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
      'first_aid': Color(0xFFE91E63),
      'other': Color(0xFF607D8B),
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
      'first_aid': '🏥',
      'other': '📦',
    };
    
    return icons[category] ?? '📦';
  }
}
