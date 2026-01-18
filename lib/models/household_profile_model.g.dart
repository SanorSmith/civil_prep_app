// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HouseholdProfileImpl _$$HouseholdProfileImplFromJson(
        Map<String, dynamic> json) =>
    _$HouseholdProfileImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      postalCode: json['postalCode'] as String,
      adultCount: (json['adultCount'] as num?)?.toInt() ?? 1,
      childCount: (json['childCount'] as num?)?.toInt() ?? 0,
      infantCount: (json['infantCount'] as num?)?.toInt() ?? 0,
      housingType: $enumDecode(_$HousingTypeEnumMap, json['housingType']),
      heatingType: $enumDecode(_$HeatingTypeEnumMap, json['heatingType']),
      allowAggregation: json['allowAggregation'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$HouseholdProfileImplToJson(
        _$HouseholdProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'postalCode': instance.postalCode,
      'adultCount': instance.adultCount,
      'childCount': instance.childCount,
      'infantCount': instance.infantCount,
      'housingType': _$HousingTypeEnumMap[instance.housingType]!,
      'heatingType': _$HeatingTypeEnumMap[instance.heatingType]!,
      'allowAggregation': instance.allowAggregation,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$HousingTypeEnumMap = {
  HousingType.apartment: 'apartment',
  HousingType.house: 'house',
  HousingType.rural: 'rural',
};

const _$HeatingTypeEnumMap = {
  HeatingType.electric: 'electric',
  HeatingType.gas: 'gas',
  HeatingType.wood: 'wood',
  HeatingType.district: 'district',
  HeatingType.other: 'other',
};
