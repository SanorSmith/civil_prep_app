import 'package:flutter/material.dart';
import '../services/items_service.dart';
import '../services/user_profile_service.dart';

class AddCustomItemDialog extends StatefulWidget {
  final String? initialCategory;
  final String? initialLevel;
  
  const AddCustomItemDialog({
    Key? key,
    this.initialCategory,
    this.initialLevel,
  }) : super(key: key);
  
  @override
  State<AddCustomItemDialog> createState() => _AddCustomItemDialogState();
}

class _AddCustomItemDialogState extends State<AddCustomItemDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _unitController = TextEditingController();
  
  String? selectedCategory;
  String? selectedLevel;
  
  final ItemsService _itemsService = ItemsService();
  final UserProfileService _userProfileService = UserProfileService();
  
  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory ?? 'water';
    selectedLevel = widget.initialLevel ?? '24h';
  }
  
  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final labels = _getLabels(languageCode);
    final categories = _getCategories(languageCode);
    final levels = _getLevels(languageCode);
    
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(labels['title']!),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                labels['categoryLabel']!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                items: categories.map((cat) {
                  return DropdownMenuItem<String>(
                    value: cat['key'],
                    child: Text(cat['label']!),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              Text(
                labels['levelLabel']!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedLevel,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                items: levels.map((level) {
                  return DropdownMenuItem<String>(
                    value: level['key'],
                    child: Text(level['label']!),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLevel = value;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: labels['nameLabel']!,
                  hintText: labels['nameHint']!,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return labels['nameRequired']!;
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: labels['descriptionLabel']!,
                  hintText: labels['descriptionHint']!,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 2,
              ),
              
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _quantityController,
                      decoration: InputDecoration(
                        labelText: labels['quantityLabel']!,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return labels['quantityRequired']!;
                        }
                        if (int.tryParse(value) == null) {
                          return labels['quantityInvalid']!;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _unitController,
                      decoration: InputDecoration(
                        labelText: labels['unitLabel']!,
                        hintText: labels['unitHint']!,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return labels['unitRequired']!;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(labels['cancelButton']!),
        ),
        ElevatedButton(
          onPressed: () => _saveItem(context, languageCode),
          child: Text(labels['saveButton']!),
        ),
      ],
    );
  }
  
  Future<void> _saveItem(BuildContext context, String languageCode) async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final description = _descriptionController.text.trim();
      final quantity = int.parse(_quantityController.text);
      final unit = _unitController.text.trim();
      
      await _itemsService.addCustomItem(
        level: selectedLevel!,
        category: selectedCategory!,
        name: name,
        description: description,
        quantity: quantity,
        unit: unit,
      );
      
      await _userProfileService.triggerAutoSave('Added custom item: $name');
      
      if (mounted) {
        Navigator.pop(context, true);
      }
    }
  }
  
  Map<String, String> _getLabels(String languageCode) {
    if (languageCode == 'en') {
      return {
        'title': 'Add Custom Item',
        'categoryLabel': 'Category',
        'levelLabel': 'Preparedness Level',
        'nameLabel': 'Item Name',
        'nameHint': 'e.g., Extra batteries',
        'nameRequired': 'Name is required',
        'descriptionLabel': 'Description (optional)',
        'descriptionHint': 'Additional details...',
        'quantityLabel': 'Quantity',
        'quantityRequired': 'Quantity is required',
        'quantityInvalid': 'Enter a valid number',
        'unitLabel': 'Unit',
        'unitHint': 'e.g., pieces, liters',
        'unitRequired': 'Unit is required',
        'cancelButton': 'Cancel',
        'saveButton': 'Add Item',
      };
    } else {
      return {
        'title': 'Lägg till egen artikel',
        'categoryLabel': 'Kategori',
        'levelLabel': 'Beredskapsnivå',
        'nameLabel': 'Artikelnamn',
        'nameHint': 't.ex. Extra batterier',
        'nameRequired': 'Namn krävs',
        'descriptionLabel': 'Beskrivning (valfritt)',
        'descriptionHint': 'Ytterligare detaljer...',
        'quantityLabel': 'Antal',
        'quantityRequired': 'Antal krävs',
        'quantityInvalid': 'Ange ett giltigt nummer',
        'unitLabel': 'Enhet',
        'unitHint': 't.ex. st, liter',
        'unitRequired': 'Enhet krävs',
        'cancelButton': 'Avbryt',
        'saveButton': 'Lägg till',
      };
    }
  }
  
  List<Map<String, String>> _getCategories(String languageCode) {
    if (languageCode == 'en') {
      return [
        {'key': 'water', 'label': '💧 Water'},
        {'key': 'food', 'label': '🍴 Food'},
        {'key': 'light', 'label': '🔦 Light'},
        {'key': 'heat', 'label': '🔥 Heat'},
        {'key': 'radio', 'label': '📻 Radio'},
        {'key': 'cash', 'label': '💵 Cash'},
        {'key': 'medicine', 'label': '💊 Medicine'},
        {'key': 'hygiene', 'label': '🧼 Hygiene'},
      ];
    } else {
      return [
        {'key': 'water', 'label': '💧 Vatten'},
        {'key': 'food', 'label': '🍴 Mat'},
        {'key': 'light', 'label': '🔦 Ljus'},
        {'key': 'heat', 'label': '🔥 Värme'},
        {'key': 'radio', 'label': '📻 Radio'},
        {'key': 'cash', 'label': '💵 Kontanter'},
        {'key': 'medicine', 'label': '💊 Medicin'},
        {'key': 'hygiene', 'label': '🧼 Hygien'},
      ];
    }
  }
  
  List<Map<String, String>> _getLevels(String languageCode) {
    if (languageCode == 'en') {
      return [
        {'key': '24h', 'label': '24 hours'},
        {'key': '72h', 'label': '72 hours'},
        {'key': '7d', 'label': '7 days'},
      ];
    } else {
      return [
        {'key': '24h', 'label': '24 timmar'},
        {'key': '72h', 'label': '72 timmar'},
        {'key': '7d', 'label': '7 dagar'},
      ];
    }
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    super.dispose();
  }
}
