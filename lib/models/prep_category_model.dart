import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'prep_category_model.freezed.dart';
part 'prep_category_model.g.dart';

@freezed
@HiveType(typeId: 5)
class PrepCategory with _$PrepCategory {
  const factory PrepCategory({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String icon,
    @HiveField(3) required int priority,
    @HiveField(4) required String msbGuideline,
  }) = _PrepCategory;

  factory PrepCategory.fromJson(Map<String, dynamic> json) => _$PrepCategoryFromJson(json);

  // Factory method for creating a category
  factory PrepCategory.create({
    required String id,
    required String name,
    required String icon,
    required int priority,
    required String msbGuideline,
  }) {
    return PrepCategory(
      id: id,
      name: name,
      icon: icon,
      priority: priority,
      msbGuideline: msbGuideline,
    );
  }

  // Predefined categories based on MSB guidelines
  static PrepCategory water() => PrepCategory(
        id: 'water',
        name: 'Water',
        icon: 'water_drop',
        priority: 1,
        msbGuideline: 'https://www.msb.se/sv/amnesomraden/krisberedskap--civilt-forsvar/krisberedskap/checklista-for-hushall/',
      );

  static PrepCategory food() => PrepCategory(
        id: 'food',
        name: 'Food',
        icon: 'restaurant',
        priority: 2,
        msbGuideline: 'https://www.msb.se/sv/amnesomraden/krisberedskap--civilt-forsvar/krisberedskap/checklista-for-hushall/',
      );

  static PrepCategory heating() => PrepCategory(
        id: 'heating',
        name: 'Heating',
        icon: 'local_fire_department',
        priority: 3,
        msbGuideline: 'https://www.msb.se/sv/amnesomraden/krisberedskap--civilt-forsvar/krisberedskap/checklista-for-hushall/',
      );

  static PrepCategory hygiene() => PrepCategory(
        id: 'hygiene',
        name: 'Hygiene',
        icon: 'clean_hands',
        priority: 4,
        msbGuideline: 'https://www.msb.se/sv/amnesomraden/krisberedskap--civilt-forsvar/krisberedskap/checklista-for-hushall/',
      );

  static PrepCategory communication() => PrepCategory(
        id: 'communication',
        name: 'Communication',
        icon: 'radio',
        priority: 5,
        msbGuideline: 'https://www.msb.se/sv/amnesomraden/krisberedskap--civilt-forsvar/krisberedskap/checklista-for-hushall/',
      );

  static PrepCategory firstAid() => PrepCategory(
        id: 'first_aid',
        name: 'First Aid',
        icon: 'medical_services',
        priority: 6,
        msbGuideline: 'https://www.msb.se/sv/amnesomraden/krisberedskap--civilt-forsvar/krisberedskap/checklista-for-hushall/',
      );

  static PrepCategory lighting() => PrepCategory(
        id: 'lighting',
        name: 'Lighting',
        icon: 'lightbulb',
        priority: 7,
        msbGuideline: 'https://www.msb.se/sv/amnesomraden/krisberedskap--civilt-forsvar/krisberedskap/checklista-for-hushall/',
      );

  static PrepCategory documents() => PrepCategory(
        id: 'documents',
        name: 'Important Documents',
        icon: 'description',
        priority: 8,
        msbGuideline: 'https://www.msb.se/sv/amnesomraden/krisberedskap--civilt-forsvar/krisberedskap/checklista-for-hushall/',
      );

  static PrepCategory cash() => PrepCategory(
        id: 'cash',
        name: 'Cash',
        icon: 'payments',
        priority: 9,
        msbGuideline: 'https://www.msb.se/sv/amnesomraden/krisberedskap--civilt-forsvar/krisberedskap/checklista-for-hushall/',
      );

  static PrepCategory other() => PrepCategory(
        id: 'other',
        name: 'Other',
        icon: 'more_horiz',
        priority: 10,
        msbGuideline: 'https://www.msb.se/sv/amnesomraden/krisberedskap--civilt-forsvar/krisberedskap/checklista-for-hushall/',
      );

  // Get all predefined categories
  static List<PrepCategory> getAllCategories() {
    return [
      water(),
      food(),
      heating(),
      hygiene(),
      communication(),
      firstAid(),
      lighting(),
      documents(),
      cash(),
      other(),
    ];
  }
}

// Hive adapter for PrepCategory model
class PrepCategoryAdapter extends TypeAdapter<PrepCategory> {
  @override
  final int typeId = 5;

  @override
  PrepCategory read(BinaryReader reader) {
    return PrepCategory(
      id: reader.read(),
      name: reader.read(),
      icon: reader.read(),
      priority: reader.read(),
      msbGuideline: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, PrepCategory obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.icon);
    writer.write(obj.priority);
    writer.write(obj.msbGuideline);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrepCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
