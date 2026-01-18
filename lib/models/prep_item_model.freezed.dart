// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prep_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PrepItem _$PrepItemFromJson(Map<String, dynamic> json) {
  return _PrepItem.fromJson(json);
}

/// @nodoc
mixin _$PrepItem {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get userId => throw _privateConstructorUsedError;
  @HiveField(2)
  String get categoryId => throw _privateConstructorUsedError;
  @HiveField(3)
  String get name => throw _privateConstructorUsedError;
  @HiveField(4)
  double get targetQuantity => throw _privateConstructorUsedError;
  @HiveField(5)
  @JsonKey(defaultValue: 0.0)
  double get currentQuantity => throw _privateConstructorUsedError;
  @HiveField(6)
  String get unit => throw _privateConstructorUsedError;
  @HiveField(7)
  @JsonKey(defaultValue: false)
  bool get isCompleted => throw _privateConstructorUsedError;
  @HiveField(8)
  DateTime? get completedAt => throw _privateConstructorUsedError;
  @HiveField(9)
  @JsonKey(defaultValue: false)
  bool get isCustom => throw _privateConstructorUsedError;
  @HiveField(10)
  @JsonKey(defaultValue: 1)
  int get syncVersion => throw _privateConstructorUsedError;
  @HiveField(11)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(12)
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this PrepItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PrepItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PrepItemCopyWith<PrepItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrepItemCopyWith<$Res> {
  factory $PrepItemCopyWith(PrepItem value, $Res Function(PrepItem) then) =
      _$PrepItemCopyWithImpl<$Res, PrepItem>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String userId,
      @HiveField(2) String categoryId,
      @HiveField(3) String name,
      @HiveField(4) double targetQuantity,
      @HiveField(5) @JsonKey(defaultValue: 0.0) double currentQuantity,
      @HiveField(6) String unit,
      @HiveField(7) @JsonKey(defaultValue: false) bool isCompleted,
      @HiveField(8) DateTime? completedAt,
      @HiveField(9) @JsonKey(defaultValue: false) bool isCustom,
      @HiveField(10) @JsonKey(defaultValue: 1) int syncVersion,
      @HiveField(11) DateTime createdAt,
      @HiveField(12) DateTime updatedAt});
}

/// @nodoc
class _$PrepItemCopyWithImpl<$Res, $Val extends PrepItem>
    implements $PrepItemCopyWith<$Res> {
  _$PrepItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PrepItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? categoryId = null,
    Object? name = null,
    Object? targetQuantity = null,
    Object? currentQuantity = null,
    Object? unit = null,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? isCustom = null,
    Object? syncVersion = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      targetQuantity: null == targetQuantity
          ? _value.targetQuantity
          : targetQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      currentQuantity: null == currentQuantity
          ? _value.currentQuantity
          : currentQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCustom: null == isCustom
          ? _value.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
      syncVersion: null == syncVersion
          ? _value.syncVersion
          : syncVersion // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrepItemImplCopyWith<$Res>
    implements $PrepItemCopyWith<$Res> {
  factory _$$PrepItemImplCopyWith(
          _$PrepItemImpl value, $Res Function(_$PrepItemImpl) then) =
      __$$PrepItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String userId,
      @HiveField(2) String categoryId,
      @HiveField(3) String name,
      @HiveField(4) double targetQuantity,
      @HiveField(5) @JsonKey(defaultValue: 0.0) double currentQuantity,
      @HiveField(6) String unit,
      @HiveField(7) @JsonKey(defaultValue: false) bool isCompleted,
      @HiveField(8) DateTime? completedAt,
      @HiveField(9) @JsonKey(defaultValue: false) bool isCustom,
      @HiveField(10) @JsonKey(defaultValue: 1) int syncVersion,
      @HiveField(11) DateTime createdAt,
      @HiveField(12) DateTime updatedAt});
}

/// @nodoc
class __$$PrepItemImplCopyWithImpl<$Res>
    extends _$PrepItemCopyWithImpl<$Res, _$PrepItemImpl>
    implements _$$PrepItemImplCopyWith<$Res> {
  __$$PrepItemImplCopyWithImpl(
      _$PrepItemImpl _value, $Res Function(_$PrepItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of PrepItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? categoryId = null,
    Object? name = null,
    Object? targetQuantity = null,
    Object? currentQuantity = null,
    Object? unit = null,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? isCustom = null,
    Object? syncVersion = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$PrepItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      targetQuantity: null == targetQuantity
          ? _value.targetQuantity
          : targetQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      currentQuantity: null == currentQuantity
          ? _value.currentQuantity
          : currentQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCustom: null == isCustom
          ? _value.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
      syncVersion: null == syncVersion
          ? _value.syncVersion
          : syncVersion // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PrepItemImpl implements _PrepItem {
  const _$PrepItemImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.userId,
      @HiveField(2) required this.categoryId,
      @HiveField(3) required this.name,
      @HiveField(4) required this.targetQuantity,
      @HiveField(5) @JsonKey(defaultValue: 0.0) this.currentQuantity = 0.0,
      @HiveField(6) required this.unit,
      @HiveField(7) @JsonKey(defaultValue: false) this.isCompleted = false,
      @HiveField(8) this.completedAt,
      @HiveField(9) @JsonKey(defaultValue: false) this.isCustom = false,
      @HiveField(10) @JsonKey(defaultValue: 1) this.syncVersion = 1,
      @HiveField(11) required this.createdAt,
      @HiveField(12) required this.updatedAt});

  factory _$PrepItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrepItemImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String userId;
  @override
  @HiveField(2)
  final String categoryId;
  @override
  @HiveField(3)
  final String name;
  @override
  @HiveField(4)
  final double targetQuantity;
  @override
  @HiveField(5)
  @JsonKey(defaultValue: 0.0)
  final double currentQuantity;
  @override
  @HiveField(6)
  final String unit;
  @override
  @HiveField(7)
  @JsonKey(defaultValue: false)
  final bool isCompleted;
  @override
  @HiveField(8)
  final DateTime? completedAt;
  @override
  @HiveField(9)
  @JsonKey(defaultValue: false)
  final bool isCustom;
  @override
  @HiveField(10)
  @JsonKey(defaultValue: 1)
  final int syncVersion;
  @override
  @HiveField(11)
  final DateTime createdAt;
  @override
  @HiveField(12)
  final DateTime updatedAt;

  @override
  String toString() {
    return 'PrepItem(id: $id, userId: $userId, categoryId: $categoryId, name: $name, targetQuantity: $targetQuantity, currentQuantity: $currentQuantity, unit: $unit, isCompleted: $isCompleted, completedAt: $completedAt, isCustom: $isCustom, syncVersion: $syncVersion, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrepItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.targetQuantity, targetQuantity) ||
                other.targetQuantity == targetQuantity) &&
            (identical(other.currentQuantity, currentQuantity) ||
                other.currentQuantity == currentQuantity) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.isCustom, isCustom) ||
                other.isCustom == isCustom) &&
            (identical(other.syncVersion, syncVersion) ||
                other.syncVersion == syncVersion) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      categoryId,
      name,
      targetQuantity,
      currentQuantity,
      unit,
      isCompleted,
      completedAt,
      isCustom,
      syncVersion,
      createdAt,
      updatedAt);

  /// Create a copy of PrepItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrepItemImplCopyWith<_$PrepItemImpl> get copyWith =>
      __$$PrepItemImplCopyWithImpl<_$PrepItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrepItemImplToJson(
      this,
    );
  }
}

abstract class _PrepItem implements PrepItem {
  const factory _PrepItem(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String userId,
      @HiveField(2) required final String categoryId,
      @HiveField(3) required final String name,
      @HiveField(4) required final double targetQuantity,
      @HiveField(5) @JsonKey(defaultValue: 0.0) final double currentQuantity,
      @HiveField(6) required final String unit,
      @HiveField(7) @JsonKey(defaultValue: false) final bool isCompleted,
      @HiveField(8) final DateTime? completedAt,
      @HiveField(9) @JsonKey(defaultValue: false) final bool isCustom,
      @HiveField(10) @JsonKey(defaultValue: 1) final int syncVersion,
      @HiveField(11) required final DateTime createdAt,
      @HiveField(12) required final DateTime updatedAt}) = _$PrepItemImpl;

  factory _PrepItem.fromJson(Map<String, dynamic> json) =
      _$PrepItemImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get userId;
  @override
  @HiveField(2)
  String get categoryId;
  @override
  @HiveField(3)
  String get name;
  @override
  @HiveField(4)
  double get targetQuantity;
  @override
  @HiveField(5)
  @JsonKey(defaultValue: 0.0)
  double get currentQuantity;
  @override
  @HiveField(6)
  String get unit;
  @override
  @HiveField(7)
  @JsonKey(defaultValue: false)
  bool get isCompleted;
  @override
  @HiveField(8)
  DateTime? get completedAt;
  @override
  @HiveField(9)
  @JsonKey(defaultValue: false)
  bool get isCustom;
  @override
  @HiveField(10)
  @JsonKey(defaultValue: 1)
  int get syncVersion;
  @override
  @HiveField(11)
  DateTime get createdAt;
  @override
  @HiveField(12)
  DateTime get updatedAt;

  /// Create a copy of PrepItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrepItemImplCopyWith<_$PrepItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
