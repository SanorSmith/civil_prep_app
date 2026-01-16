import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'household_profile_model.freezed.dart';
part 'household_profile_model.g.dart';

// Enums for HousingType and HeatingType
@HiveType(typeId: 2)
enum HousingType {
  @HiveField(0)
  apartment,
  @HiveField(1)
  house,
  @HiveField(2)
  rural;
}

@HiveType(typeId: 3)
enum HeatingType {
  @HiveField(0)
  electric,
  @HiveField(1)
  gas,
  @HiveField(2)
  wood,
  @HiveField(3)
  district,
  @HiveField(4)
  other;
}

@freezed
@HiveType(typeId: 1)
class HouseholdProfile with _$HouseholdProfile {
  const factory HouseholdProfile({
    @HiveField(0) required String id,
    @HiveField(1) required String userId,
    @HiveField(2) required String postalCode,
    @HiveField(3) @Default(1) @JsonKey(defaultValue: 1) int adultCount,
    @HiveField(4) @Default(0) @JsonKey(defaultValue: 0) int childCount,
    @HiveField(5) @Default(0) @JsonKey(defaultValue: 0) int infantCount,
    @HiveField(6) required HousingType housingType,
    @HiveField(7) required HeatingType heatingType,
    @HiveField(8) @Default(false) @JsonKey(defaultValue: false) bool allowAggregation,
    @HiveField(9) required DateTime createdAt,
    @HiveField(10) required DateTime updatedAt,
  }) = _HouseholdProfile;

  factory HouseholdProfile.fromJson(Map<String, dynamic> json) => _$HouseholdProfileFromJson(json);

  // Factory method for creating a new household profile
  factory HouseholdProfile.create({
    required String userId,
    required String postalCode,
    required HousingType housingType,
    required HeatingType heatingType,
    int adultCount = 1,
    int childCount = 0,
    int infantCount = 0,
    bool allowAggregation = false,
  }) {
    final now = DateTime.now();
    return HouseholdProfile(
      id: const Uuid().v4(),
      userId: userId,
      postalCode: postalCode,
      adultCount: adultCount,
      childCount: childCount,
      infantCount: infantCount,
      housingType: housingType,
      heatingType: heatingType,
      allowAggregation: allowAggregation,
      createdAt: now,
      updatedAt: now,
    );
  }

  // Factory method for updating an existing profile
  factory HouseholdProfile.update({
    required HouseholdProfile existing,
    String? postalCode,
    int? adultCount,
    int? childCount,
    int? infantCount,
    HousingType? housingType,
    HeatingType? heatingType,
    bool? allowAggregation,
  }) {
    return HouseholdProfile(
      id: existing.id,
      userId: existing.userId,
      postalCode: postalCode ?? existing.postalCode,
      adultCount: adultCount ?? existing.adultCount,
      childCount: childCount ?? existing.childCount,
      infantCount: infantCount ?? existing.infantCount,
      housingType: housingType ?? existing.housingType,
      heatingType: heatingType ?? existing.heatingType,
      allowAggregation: allowAggregation ?? existing.allowAggregation,
      createdAt: existing.createdAt,
      updatedAt: DateTime.now(),
    );
  }
}

// Hive adapter for HouseholdProfile model
class HouseholdProfileAdapter extends TypeAdapter<HouseholdProfile> {
  @override
  final int typeId = 1;

  @override
  HouseholdProfile read(BinaryReader reader) {
    return HouseholdProfile(
      id: reader.read(),
      userId: reader.read(),
      postalCode: reader.read(),
      adultCount: reader.read(),
      childCount: reader.read(),
      infantCount: reader.read(),
      housingType: reader.read(),
      heatingType: reader.read(),
      allowAggregation: reader.read(),
      createdAt: reader.read(),
      updatedAt: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, HouseholdProfile obj) {
    writer.write(obj.id);
    writer.write(obj.userId);
    writer.write(obj.postalCode);
    writer.write(obj.adultCount);
    writer.write(obj.childCount);
    writer.write(obj.infantCount);
    writer.write(obj.housingType);
    writer.write(obj.heatingType);
    writer.write(obj.allowAggregation);
    writer.write(obj.createdAt);
    writer.write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HouseholdProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// Hive adapter for HousingType enum
class HousingTypeAdapter extends TypeAdapter<HousingType> {
  @override
  final int typeId = 2;

  @override
  HousingType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return HousingType.apartment;
      case 1:
        return HousingType.house;
      case 2:
        return HousingType.rural;
      default:
        throw ArgumentError('Invalid HousingType');
    }
  }

  @override
  void write(BinaryWriter writer, HousingType obj) {
    switch (obj) {
      case HousingType.apartment:
        writer.writeByte(0);
        break;
      case HousingType.house:
        writer.writeByte(1);
        break;
      case HousingType.rural:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HousingTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// Hive adapter for HeatingType enum
class HeatingTypeAdapter extends TypeAdapter<HeatingType> {
  @override
  final int typeId = 3;

  @override
  HeatingType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return HeatingType.electric;
      case 1:
        return HeatingType.gas;
      case 2:
        return HeatingType.wood;
      case 3:
        return HeatingType.district;
      case 4:
        return HeatingType.other;
      default:
        throw ArgumentError('Invalid HeatingType');
    }
  }

  @override
  void write(BinaryWriter writer, HeatingType obj) {
    switch (obj) {
      case HeatingType.electric:
        writer.writeByte(0);
        break;
      case HeatingType.gas:
        writer.writeByte(1);
        break;
      case HeatingType.wood:
        writer.writeByte(2);
        break;
      case HeatingType.district:
        writer.writeByte(3);
        break;
      case HeatingType.other:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeatingTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
