// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prep_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PrepItemImpl _$$PrepItemImplFromJson(Map<String, dynamic> json) =>
    _$PrepItemImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      categoryId: json['categoryId'] as String,
      name: json['name'] as String,
      targetQuantity: (json['targetQuantity'] as num).toDouble(),
      currentQuantity: (json['currentQuantity'] as num?)?.toDouble() ?? 0.0,
      unit: json['unit'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      isCustom: json['isCustom'] as bool? ?? false,
      syncVersion: (json['syncVersion'] as num?)?.toInt() ?? 1,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$PrepItemImplToJson(_$PrepItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'categoryId': instance.categoryId,
      'name': instance.name,
      'targetQuantity': instance.targetQuantity,
      'currentQuantity': instance.currentQuantity,
      'unit': instance.unit,
      'isCompleted': instance.isCompleted,
      'completedAt': instance.completedAt?.toIso8601String(),
      'isCustom': instance.isCustom,
      'syncVersion': instance.syncVersion,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
