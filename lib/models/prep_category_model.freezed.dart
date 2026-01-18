// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prep_category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PrepCategory _$PrepCategoryFromJson(Map<String, dynamic> json) {
  return _PrepCategory.fromJson(json);
}

/// @nodoc
mixin _$PrepCategory {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String get icon => throw _privateConstructorUsedError;
  @HiveField(3)
  int get priority => throw _privateConstructorUsedError;
  @HiveField(4)
  String get msbGuideline => throw _privateConstructorUsedError;

  /// Serializes this PrepCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PrepCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PrepCategoryCopyWith<PrepCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrepCategoryCopyWith<$Res> {
  factory $PrepCategoryCopyWith(
          PrepCategory value, $Res Function(PrepCategory) then) =
      _$PrepCategoryCopyWithImpl<$Res, PrepCategory>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String icon,
      @HiveField(3) int priority,
      @HiveField(4) String msbGuideline});
}

/// @nodoc
class _$PrepCategoryCopyWithImpl<$Res, $Val extends PrepCategory>
    implements $PrepCategoryCopyWith<$Res> {
  _$PrepCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PrepCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = null,
    Object? priority = null,
    Object? msbGuideline = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      msbGuideline: null == msbGuideline
          ? _value.msbGuideline
          : msbGuideline // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrepCategoryImplCopyWith<$Res>
    implements $PrepCategoryCopyWith<$Res> {
  factory _$$PrepCategoryImplCopyWith(
          _$PrepCategoryImpl value, $Res Function(_$PrepCategoryImpl) then) =
      __$$PrepCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String icon,
      @HiveField(3) int priority,
      @HiveField(4) String msbGuideline});
}

/// @nodoc
class __$$PrepCategoryImplCopyWithImpl<$Res>
    extends _$PrepCategoryCopyWithImpl<$Res, _$PrepCategoryImpl>
    implements _$$PrepCategoryImplCopyWith<$Res> {
  __$$PrepCategoryImplCopyWithImpl(
      _$PrepCategoryImpl _value, $Res Function(_$PrepCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of PrepCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = null,
    Object? priority = null,
    Object? msbGuideline = null,
  }) {
    return _then(_$PrepCategoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      msbGuideline: null == msbGuideline
          ? _value.msbGuideline
          : msbGuideline // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PrepCategoryImpl implements _PrepCategory {
  const _$PrepCategoryImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.icon,
      @HiveField(3) required this.priority,
      @HiveField(4) required this.msbGuideline});

  factory _$PrepCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrepCategoryImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final String icon;
  @override
  @HiveField(3)
  final int priority;
  @override
  @HiveField(4)
  final String msbGuideline;

  @override
  String toString() {
    return 'PrepCategory(id: $id, name: $name, icon: $icon, priority: $priority, msbGuideline: $msbGuideline)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrepCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.msbGuideline, msbGuideline) ||
                other.msbGuideline == msbGuideline));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, icon, priority, msbGuideline);

  /// Create a copy of PrepCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrepCategoryImplCopyWith<_$PrepCategoryImpl> get copyWith =>
      __$$PrepCategoryImplCopyWithImpl<_$PrepCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrepCategoryImplToJson(
      this,
    );
  }
}

abstract class _PrepCategory implements PrepCategory {
  const factory _PrepCategory(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String name,
      @HiveField(2) required final String icon,
      @HiveField(3) required final int priority,
      @HiveField(4) required final String msbGuideline}) = _$PrepCategoryImpl;

  factory _PrepCategory.fromJson(Map<String, dynamic> json) =
      _$PrepCategoryImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  String get icon;
  @override
  @HiveField(3)
  int get priority;
  @override
  @HiveField(4)
  String get msbGuideline;

  /// Create a copy of PrepCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrepCategoryImplCopyWith<_$PrepCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
