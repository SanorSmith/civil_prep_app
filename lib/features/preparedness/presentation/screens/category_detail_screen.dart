import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../models/prep_category_model.dart';
import '../../../../core/services/items_service.dart';
import '../../../../core/models/preparedness_item.dart';
import '../../../../core/widgets/add_custom_item_dialog.dart';

class CategoryDetailScreen extends StatefulWidget {
  final String categoryId;

  const CategoryDetailScreen({
    super.key,
    required this.categoryId,
  });

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  final ItemsService _itemsService = ItemsService();
  
  String selectedLevel = '24h';
  List<PreparednessItem> items = [];
  bool isLoading = true;
  double categoryProgress = 0.0;
  double overallCategoryProgress = 0.0;
  int overallCompletedCount = 0;
  int overallTotalCount = 0;
  PrepCategory? category;

  @override
  void initState() {
    super.initState();
    _loadCategory();
    _loadItems();
    _loadOverallProgress();
  }
  
  void _loadCategory() {
    final allCategories = PrepCategory.getAllCategories();
    category = allCategories.firstWhere(
      (cat) => cat.id == widget.categoryId,
      orElse: () => PrepCategory.other(),
    );
  }
  
  Future<void> _loadOverallProgress() async {
    final allItems = await _itemsService.getAllItems();
    final categoryItems = allItems.where((item) => item.category == widget.categoryId).toList();
    
    final completed = categoryItems.where((item) => item.isCompleted).length;
    final total = categoryItems.length;
    final progress = total > 0 ? (completed / total) * 100 : 0.0;
    
    if (mounted) {
      setState(() {
        overallCompletedCount = completed;
        overallTotalCount = total;
        overallCategoryProgress = progress;
      });
    }
  }
  
  Future<void> _loadItems() async {
    setState(() => isLoading = true);
    
    final levelItems = await _itemsService.getItemsByLevelAndCategory(
      level: selectedLevel,
      category: widget.categoryId,
    );
    
    final progress = await _itemsService.getCategoryProgress(
      level: selectedLevel,
      category: widget.categoryId,
    );
    
    if (mounted) {
      setState(() {
        items = levelItems;
        categoryProgress = progress;
        isLoading = false;
      });
    }
  }

  IconData _getCategoryIcon(String iconName) {
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

  Color _getCategoryColor() {
    switch (widget.categoryId) {
      case 'water': return Color(0xFF2196F3);
      case 'food': return Color(0xFF4CAF50);
      case 'heating': return Color(0xFFFF5722);
      case 'hygiene': return Color(0xFF9C27B0);
      case 'communication': return Color(0xFFFF9800);
      case 'first_aid': return Color(0xFFF44336);
      case 'lighting': return Color(0xFFFFC107);
      case 'documents': return Color(0xFF607D8B);
      case 'cash': return Color(0xFF4CAF50);
      default: return Color(0xFF9E9E9E);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (category == null) {
      return const Scaffold(
        body: Center(child: Text('Category not found')),
      );
    }

    final completedCount = items.where((item) => item.isCompleted).length;
    final totalCount = items.length;
    final categoryColor = _getCategoryColor();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: categoryColor,
        title: Text(category!.name),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: Text(
                '${categoryProgress.toInt()}%',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: categoryColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      _getCategoryIcon(category!.icon),
                      size: 40,
                      color: categoryColor,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '$overallCompletedCount av $overallTotalCount klart',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: overallTotalCount > 0 ? overallCompletedCount / overallTotalCount : 0,
                    minHeight: 8,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation(categoryColor),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '${overallCategoryProgress.toInt()}%',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: categoryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey[300]!, width: 1),
            ),
            child: Row(
              children: [
                _buildTab('24h', categoryColor),
                _buildTab('72h', categoryColor),
                _buildTab('7 dagar', categoryColor, isLast: true),
              ],
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Inga items för $selectedLevel',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: items.length,
                    itemBuilder: (context, index) => _buildItemCard(items[index], categoryColor),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddCustomItemDialog,
        icon: Icon(Icons.add),
        label: Text(
          Localizations.localeOf(context).languageCode == 'en' 
            ? 'Add custom' 
            : 'Lägg till egen',
        ),
        backgroundColor: categoryColor,
      ),
    );
  }
  
  Widget _buildTab(String label, Color categoryColor, {bool isLast = false}) {
    final level = label == '7 dagar' ? '7d' : label;
    final isSelected = selectedLevel == level;
    
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          setState(() => selectedLevel = level);
          _loadItems();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? categoryColor : Colors.transparent,
            borderRadius: BorderRadius.horizontal(
              left: label == '24h' ? Radius.circular(25) : Radius.zero,
              right: isLast ? Radius.circular(25) : Radius.zero,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSelected) Icon(Icons.check, color: Colors.white, size: 18),
              if (isSelected) SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[800],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildItemCard(PreparednessItem item, Color categoryColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: item.isCompleted 
            ? categoryColor.withOpacity(0.5)
            : Colors.grey[300]!,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _toggleItem(item),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Checkbox(
                  value: item.isCompleted,
                  onChanged: (_) => _toggleItem(item),
                  activeColor: categoryColor,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.getName(Localizations.localeOf(context).languageCode),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: item.isCompleted ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        item.getDescription(Localizations.localeOf(context).languageCode),
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Mål: ${item.baseQuantity} ${item.unit}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: categoryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (item.isCustom)
                  IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => _deleteCustomItem(item),
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
    await _loadOverallProgress();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item.getName(Localizations.localeOf(context).languageCode)} ${!item.isCompleted ? "klar" : "ofullständig"}!'),
          backgroundColor: !item.isCompleted ? Color(0xFF4CAF50) : Color(0xFFFF9800),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
  
  Future<void> _showAddCustomItemDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AddCustomItemDialog(
        initialLevel: selectedLevel,
        initialCategory: widget.categoryId,
      ),
    );
    
    if (result == true) {
      await _loadItems();
      await _loadOverallProgress();
    }
  }
  
  Future<void> _deleteCustomItem(PreparednessItem item) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ta bort ${item.getName(Localizations.localeOf(context).languageCode)}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Avbryt'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Ta bort'),
          ),
        ],
      ),
    );
    
    if (confirm == true) {
      await _itemsService.deleteCustomItem(item.id);
      await _loadItems();
      await _loadOverallProgress();
    }
  }
}
