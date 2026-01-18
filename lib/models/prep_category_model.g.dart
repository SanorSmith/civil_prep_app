// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prep_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PrepCategoryImpl _$$PrepCategoryImplFromJson(Map<String, dynamic> json) =>
    _$PrepCategoryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      priority: (json['priority'] as num).toInt(),
      msbGuideline: json['msbGuideline'] as String,
    );

Map<String, dynamic> _$$PrepCategoryImplToJson(_$PrepCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'priority': instance.priority,
      'msbGuideline': instance.msbGuideline,
    };
