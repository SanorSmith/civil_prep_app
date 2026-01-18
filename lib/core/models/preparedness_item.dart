class PreparednessItem {
  final String id;
  final String level;
  final String category;
  
  // Bilingual fields
  final String nameSv;
  final String nameEn;
  final String descriptionSv;
  final String descriptionEn;
  
  final int baseQuantity;
  final String unit;
  final bool isCompleted;
  final DateTime? completedAt;
  final bool isCustom;
  
  PreparednessItem({
    required this.id,
    required this.level,
    required this.category,
    required this.nameSv,
    required this.nameEn,
    required this.descriptionSv,
    required this.descriptionEn,
    required this.baseQuantity,
    required this.unit,
    this.isCompleted = false,
    this.completedAt,
    this.isCustom = false,
  });
  
  // Get name in current language
  String getName(String languageCode) {
    return languageCode == 'en' ? nameEn : nameSv;
  }
  
  // Get description in current language
  String getDescription(String languageCode) {
    return languageCode == 'en' ? descriptionEn : descriptionSv;
  }
  
  // Backwards compatibility - default to Swedish
  String get name => nameSv;
  String get description => descriptionSv;
  
  static String generateId({
    required String level,
    required String category,
    String? customSuffix,
  }) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final suffix = customSuffix ?? timestamp.toString();
    return '${level}_${category}_$suffix';
  }
  
  PreparednessItem copyWith({
    bool? isCompleted,
    DateTime? completedAt,
    int? baseQuantity,
    String? nameSv,
    String? nameEn,
    String? descriptionSv,
    String? descriptionEn,
  }) {
    return PreparednessItem(
      id: this.id,
      level: this.level,
      category: this.category,
      nameSv: nameSv ?? this.nameSv,
      nameEn: nameEn ?? this.nameEn,
      descriptionSv: descriptionSv ?? this.descriptionSv,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      baseQuantity: baseQuantity ?? this.baseQuantity,
      unit: this.unit,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      isCustom: this.isCustom,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'level': level,
      'category': category,
      'nameSv': nameSv,
      'nameEn': nameEn,
      'descriptionSv': descriptionSv,
      'descriptionEn': descriptionEn,
      'baseQuantity': baseQuantity,
      'unit': unit,
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
      'isCustom': isCustom,
    };
  }
  
  factory PreparednessItem.fromJson(Map<String, dynamic> json) {
    // Backwards compatibility: if old 'name' field exists, use it for both languages
    final oldName = json['name'] as String?;
    final oldDescription = json['description'] as String?;
    
    return PreparednessItem(
      id: json['id'],
      level: json['level'],
      category: json['category'],
      nameSv: json['nameSv'] ?? oldName ?? '',
      nameEn: json['nameEn'] ?? oldName ?? '',
      descriptionSv: json['descriptionSv'] ?? oldDescription ?? '',
      descriptionEn: json['descriptionEn'] ?? oldDescription ?? '',
      baseQuantity: json['baseQuantity'],
      unit: json['unit'],
      isCompleted: json['isCompleted'] ?? false,
      completedAt: json['completedAt'] != null 
        ? DateTime.parse(json['completedAt'])
        : null,
      isCustom: json['isCustom'] ?? false,
    );
  }
}
