// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'household_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HouseholdProfile _$HouseholdProfileFromJson(Map<String, dynamic> json) {
  return _HouseholdProfile.fromJson(json);
}

/// @nodoc
mixin _$HouseholdProfile {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get userId => throw _privateConstructorUsedError;
  @HiveField(2)
  String get postalCode => throw _privateConstructorUsedError;
  @HiveField(3)
  @JsonKey(defaultValue: 1)
  int get adultCount => throw _privateConstructorUsedError;
  @HiveField(4)
  @JsonKey(defaultValue: 0)
  int get childCount => throw _privateConstructorUsedError;
  @HiveField(5)
  @JsonKey(defaultValue: 0)
  int get infantCount => throw _privateConstructorUsedError;
  @HiveField(6)
  HousingType get housingType => throw _privateConstructorUsedError;
  @HiveField(7)
  HeatingType get heatingType => throw _privateConstructorUsedError;
  @HiveField(8)
  @JsonKey(defaultValue: false)
  bool get allowAggregation => throw _privateConstructorUsedError;
  @HiveField(9)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(10)
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this HouseholdProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HouseholdProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HouseholdProfileCopyWith<HouseholdProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HouseholdProfileCopyWith<$Res> {
  factory $HouseholdProfileCopyWith(
          HouseholdProfile value, $Res Function(HouseholdProfile) then) =
      _$HouseholdProfileCopyWithImpl<$Res, HouseholdProfile>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String userId,
      @HiveField(2) String postalCode,
      @HiveField(3) @JsonKey(defaultValue: 1) int adultCount,
      @HiveField(4) @JsonKey(defaultValue: 0) int childCount,
      @HiveField(5) @JsonKey(defaultValue: 0) int infantCount,
      @HiveField(6) HousingType housingType,
      @HiveField(7) HeatingType heatingType,
      @HiveField(8) @JsonKey(defaultValue: false) bool allowAggregation,
      @HiveField(9) DateTime createdAt,
      @HiveField(10) DateTime updatedAt});
}

/// @nodoc
class _$HouseholdProfileCopyWithImpl<$Res, $Val extends HouseholdProfile>
    implements $HouseholdProfileCopyWith<$Res> {
  _$HouseholdProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HouseholdProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? postalCode = null,
    Object? adultCount = null,
    Object? childCount = null,
    Object? infantCount = null,
    Object? housingType = null,
    Object? heatingType = null,
    Object? allowAggregation = null,
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
      postalCode: null == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String,
      adultCount: null == adultCount
          ? _value.adultCount
          : adultCount // ignore: cast_nullable_to_non_nullable
              as int,
      childCount: null == childCount
          ? _value.childCount
          : childCount // ignore: cast_nullable_to_non_nullable
              as int,
      infantCount: null == infantCount
          ? _value.infantCount
          : infantCount // ignore: cast_nullable_to_non_nullable
              as int,
      housingType: null == housingType
          ? _value.housingType
          : housingType // ignore: cast_nullable_to_non_nullable
              as HousingType,
      heatingType: null == heatingType
          ? _value.heatingType
          : heatingType // ignore: cast_nullable_to_non_nullable
              as HeatingType,
      allowAggregation: null == allowAggregation
          ? _value.allowAggregation
          : allowAggregation // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$HouseholdProfileImplCopyWith<$Res>
    implements $HouseholdProfileCopyWith<$Res> {
  factory _$$HouseholdProfileImplCopyWith(_$HouseholdProfileImpl value,
          $Res Function(_$HouseholdProfileImpl) then) =
      __$$HouseholdProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String userId,
      @HiveField(2) String postalCode,
      @HiveField(3) @JsonKey(defaultValue: 1) int adultCount,
      @HiveField(4) @JsonKey(defaultValue: 0) int childCount,
      @HiveField(5) @JsonKey(defaultValue: 0) int infantCount,
      @HiveField(6) HousingType housingType,
      @HiveField(7) HeatingType heatingType,
      @HiveField(8) @JsonKey(defaultValue: false) bool allowAggregation,
      @HiveField(9) DateTime createdAt,
      @HiveField(10) DateTime updatedAt});
}

/// @nodoc
class __$$HouseholdProfileImplCopyWithImpl<$Res>
    extends _$HouseholdProfileCopyWithImpl<$Res, _$HouseholdProfileImpl>
    implements _$$HouseholdProfileImplCopyWith<$Res> {
  __$$HouseholdProfileImplCopyWithImpl(_$HouseholdProfileImpl _value,
      $Res Function(_$HouseholdProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of HouseholdProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? postalCode = null,
    Object? adultCount = null,
    Object? childCount = null,
    Object? infantCount = null,
    Object? housingType = null,
    Object? heatingType = null,
    Object? allowAggregation = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$HouseholdProfileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      postalCode: null == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String,
      adultCount: null == adultCount
          ? _value.adultCount
          : adultCount // ignore: cast_nullable_to_non_nullable
              as int,
      childCount: null == childCount
          ? _value.childCount
          : childCount // ignore: cast_nullable_to_non_nullable
              as int,
      infantCount: null == infantCount
          ? _value.infantCount
          : infantCount // ignore: cast_nullable_to_non_nullable
              as int,
      housingType: null == housingType
          ? _value.housingType
          : housingType // ignore: cast_nullable_to_non_nullable
              as HousingType,
      heatingType: null == heatingType
          ? _value.heatingType
          : heatingType // ignore: cast_nullable_to_non_nullable
              as HeatingType,
      allowAggregation: null == allowAggregation
          ? _value.allowAggregation
          : allowAggregation // ignore: cast_nullable_to_non_nullable
              as bool,
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
class _$HouseholdProfileImpl implements _HouseholdProfile {
  const _$HouseholdProfileImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.userId,
      @HiveField(2) required this.postalCode,
      @HiveField(3) @JsonKey(defaultValue: 1) this.adultCount = 1,
      @HiveField(4) @JsonKey(defaultValue: 0) this.childCount = 0,
      @HiveField(5) @JsonKey(defaultValue: 0) this.infantCount = 0,
      @HiveField(6) required this.housingType,
      @HiveField(7) required this.heatingType,
      @HiveField(8) @JsonKey(defaultValue: false) this.allowAggregation = false,
      @HiveField(9) required this.createdAt,
      @HiveField(10) required this.updatedAt});

  factory _$HouseholdProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$HouseholdProfileImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String userId;
  @override
  @HiveField(2)
  final String postalCode;
  @override
  @HiveField(3)
  @JsonKey(defaultValue: 1)
  final int adultCount;
  @override
  @HiveField(4)
  @JsonKey(defaultValue: 0)
  final int childCount;
  @override
  @HiveField(5)
  @JsonKey(defaultValue: 0)
  final int infantCount;
  @override
  @HiveField(6)
  final HousingType housingType;
  @override
  @HiveField(7)
  final HeatingType heatingType;
  @override
  @HiveField(8)
  @JsonKey(defaultValue: false)
  final bool allowAggregation;
  @override
  @HiveField(9)
  final DateTime createdAt;
  @override
  @HiveField(10)
  final DateTime updatedAt;

  @override
  String toString() {
    return 'HouseholdProfile(id: $id, userId: $userId, postalCode: $postalCode, adultCount: $adultCount, childCount: $childCount, infantCount: $infantCount, housingType: $housingType, heatingType: $heatingType, allowAggregation: $allowAggregation, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HouseholdProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.adultCount, adultCount) ||
                other.adultCount == adultCount) &&
            (identical(other.childCount, childCount) ||
                other.childCount == childCount) &&
            (identical(other.infantCount, infantCount) ||
                other.infantCount == infantCount) &&
            (identical(other.housingType, housingType) ||
                other.housingType == housingType) &&
            (identical(other.heatingType, heatingType) ||
                other.heatingType == heatingType) &&
            (identical(other.allowAggregation, allowAggregation) ||
                other.allowAggregation == allowAggregation) &&
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
      postalCode,
      adultCount,
      childCount,
      infantCount,
      housingType,
      heatingType,
      allowAggregation,
      createdAt,
      updatedAt);

  /// Create a copy of HouseholdProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HouseholdProfileImplCopyWith<_$HouseholdProfileImpl> get copyWith =>
      __$$HouseholdProfileImplCopyWithImpl<_$HouseholdProfileImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HouseholdProfileImplToJson(
      this,
    );
  }
}

abstract class _HouseholdProfile implements HouseholdProfile {
  const factory _HouseholdProfile(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String userId,
      @HiveField(2) required final String postalCode,
      @HiveField(3) @JsonKey(defaultValue: 1) final int adultCount,
      @HiveField(4) @JsonKey(defaultValue: 0) final int childCount,
      @HiveField(5) @JsonKey(defaultValue: 0) final int infantCount,
      @HiveField(6) required final HousingType housingType,
      @HiveField(7) required final HeatingType heatingType,
      @HiveField(8) @JsonKey(defaultValue: false) final bool allowAggregation,
      @HiveField(9) required final DateTime createdAt,
      @HiveField(10)
      required final DateTime updatedAt}) = _$HouseholdProfileImpl;

  factory _HouseholdProfile.fromJson(Map<String, dynamic> json) =
      _$HouseholdProfileImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get userId;
  @override
  @HiveField(2)
  String get postalCode;
  @override
  @HiveField(3)
  @JsonKey(defaultValue: 1)
  int get adultCount;
  @override
  @HiveField(4)
  @JsonKey(defaultValue: 0)
  int get childCount;
  @override
  @HiveField(5)
  @JsonKey(defaultValue: 0)
  int get infantCount;
  @override
  @HiveField(6)
  HousingType get housingType;
  @override
  @HiveField(7)
  HeatingType get heatingType;
  @override
  @HiveField(8)
  @JsonKey(defaultValue: false)
  bool get allowAggregation;
  @override
  @HiveField(9)
  DateTime get createdAt;
  @override
  @HiveField(10)
  DateTime get updatedAt;

  /// Create a copy of HouseholdProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HouseholdProfileImplCopyWith<_$HouseholdProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
