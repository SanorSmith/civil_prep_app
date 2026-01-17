import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'prep_item_model.freezed.dart';
part 'prep_item_model.g.dart';

@freezed
@HiveType(typeId: 4)
class PrepItem with _$PrepItem {
  const factory PrepItem({
    @HiveField(0) required String id,
    @HiveField(1) required String userId,
    @HiveField(2) required String categoryId,
    @HiveField(3) required String name,
    @HiveField(4) required double targetQuantity,
    @HiveField(5) @Default(0.0) @JsonKey(defaultValue: 0.0) double currentQuantity,
    @HiveField(6) required String unit,
    @HiveField(7) @Default(false) @JsonKey(defaultValue: false) bool isCompleted,
    @HiveField(8) DateTime? completedAt,
    @HiveField(9) @Default(false) @JsonKey(defaultValue: false) bool isCustom,
    @HiveField(10) @Default(1) @JsonKey(defaultValue: 1) int syncVersion,
    @HiveField(11) required DateTime createdAt,
    @HiveField(12) required DateTime updatedAt,
  }) = _PrepItem;

  factory PrepItem.fromJson(Map<String, dynamic> json) => _$PrepItemFromJson(json);

  // Factory method for creating a new prep item
  factory PrepItem.create({
    required String userId,
    required String categoryId,
    required String name,
    required double targetQuantity,
    required String unit,
    double currentQuantity = 0.0,
    bool isCustom = false,
  }) {
    final now = DateTime.now();
    return PrepItem(
      id: const Uuid().v4(),
      userId: userId,
      categoryId: categoryId,
      name: name,
      targetQuantity: targetQuantity,
      currentQuantity: currentQuantity,
      unit: unit,
      isCompleted: false,
      completedAt: null,
      isCustom: isCustom,
      syncVersion: 1,
      createdAt: now,
      updatedAt: now,
    );
  }

  // Factory method for updating quantity
  factory PrepItem.updateQuantity({
    required PrepItem existing,
    required double newQuantity,
  }) {
    final isNowCompleted = newQuantity >= existing.targetQuantity;
    return PrepItem(
      id: existing.id,
      userId: existing.userId,
      categoryId: existing.categoryId,
      name: existing.name,
      targetQuantity: existing.targetQuantity,
      currentQuantity: newQuantity,
      unit: existing.unit,
      isCompleted: isNowCompleted,
      completedAt: isNowCompleted ? DateTime.now() : null,
      isCustom: existing.isCustom,
      syncVersion: existing.syncVersion + 1,
      createdAt: existing.createdAt,
      updatedAt: DateTime.now(),
    );
  }

  // Factory method for marking as complete
  factory PrepItem.markComplete({
    required PrepItem existing,
    required bool completed,
  }) {
    return PrepItem(
      id: existing.id,
      userId: existing.userId,
      categoryId: existing.categoryId,
      name: existing.name,
      targetQuantity: existing.targetQuantity,
      currentQuantity: completed ? existing.targetQuantity : 0,
      unit: existing.unit,
      isCompleted: completed,
      completedAt: completed ? DateTime.now() : null,
      isCustom: existing.isCustom,
      syncVersion: existing.syncVersion + 1,
      createdAt: existing.createdAt,
      updatedAt: DateTime.now(),
    );
  }
}

// Hive adapter for PrepItem model
class PrepItemAdapter extends TypeAdapter<PrepItem> {
  @override
  final int typeId = 4;

  @override
  PrepItem read(BinaryReader reader) {
    return PrepItem(
      id: reader.read(),
      userId: reader.read(),
      categoryId: reader.read(),
      name: reader.read(),
      targetQuantity: reader.read(),
      currentQuantity: reader.read(),
      unit: reader.read(),
      isCompleted: reader.read(),
      completedAt: reader.read(),
      isCustom: reader.read(),
      syncVersion: reader.read(),
      createdAt: reader.read(),
      updatedAt: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, PrepItem obj) {
    writer.write(obj.id);
    writer.write(obj.userId);
    writer.write(obj.categoryId);
    writer.write(obj.name);
    writer.write(obj.targetQuantity);
    writer.write(obj.currentQuantity);
    writer.write(obj.unit);
    writer.write(obj.isCompleted);
    writer.write(obj.completedAt);
    writer.write(obj.isCustom);
    writer.write(obj.syncVersion);
    writer.write(obj.createdAt);
    writer.write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrepItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
