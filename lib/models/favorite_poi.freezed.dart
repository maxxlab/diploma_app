// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_poi.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FavoritePOI _$FavoritePOIFromJson(Map<String, dynamic> json) {
  return _FavoritePOI.fromJson(json);
}

/// @nodoc
mixin _$FavoritePOI {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get poiId => throw _privateConstructorUsedError;
  String get poiName => throw _privateConstructorUsedError;
  String get poiDescription => throw _privateConstructorUsedError;
  String get poiCategory => throw _privateConstructorUsedError;
  double get poiLatitude => throw _privateConstructorUsedError;
  double get poiLongitude => throw _privateConstructorUsedError;
  String? get poiAddress => throw _privateConstructorUsedError;
  double get poiRating => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this FavoritePOI to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FavoritePOI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavoritePOICopyWith<FavoritePOI> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoritePOICopyWith<$Res> {
  factory $FavoritePOICopyWith(
          FavoritePOI value, $Res Function(FavoritePOI) then) =
      _$FavoritePOICopyWithImpl<$Res, FavoritePOI>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String poiId,
      String poiName,
      String poiDescription,
      String poiCategory,
      double poiLatitude,
      double poiLongitude,
      String? poiAddress,
      double poiRating,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime? createdAt});
}

/// @nodoc
class _$FavoritePOICopyWithImpl<$Res, $Val extends FavoritePOI>
    implements $FavoritePOICopyWith<$Res> {
  _$FavoritePOICopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoritePOI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? poiId = null,
    Object? poiName = null,
    Object? poiDescription = null,
    Object? poiCategory = null,
    Object? poiLatitude = null,
    Object? poiLongitude = null,
    Object? poiAddress = freezed,
    Object? poiRating = null,
    Object? createdAt = freezed,
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
      poiId: null == poiId
          ? _value.poiId
          : poiId // ignore: cast_nullable_to_non_nullable
              as String,
      poiName: null == poiName
          ? _value.poiName
          : poiName // ignore: cast_nullable_to_non_nullable
              as String,
      poiDescription: null == poiDescription
          ? _value.poiDescription
          : poiDescription // ignore: cast_nullable_to_non_nullable
              as String,
      poiCategory: null == poiCategory
          ? _value.poiCategory
          : poiCategory // ignore: cast_nullable_to_non_nullable
              as String,
      poiLatitude: null == poiLatitude
          ? _value.poiLatitude
          : poiLatitude // ignore: cast_nullable_to_non_nullable
              as double,
      poiLongitude: null == poiLongitude
          ? _value.poiLongitude
          : poiLongitude // ignore: cast_nullable_to_non_nullable
              as double,
      poiAddress: freezed == poiAddress
          ? _value.poiAddress
          : poiAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      poiRating: null == poiRating
          ? _value.poiRating
          : poiRating // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FavoritePOIImplCopyWith<$Res>
    implements $FavoritePOICopyWith<$Res> {
  factory _$$FavoritePOIImplCopyWith(
          _$FavoritePOIImpl value, $Res Function(_$FavoritePOIImpl) then) =
      __$$FavoritePOIImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String poiId,
      String poiName,
      String poiDescription,
      String poiCategory,
      double poiLatitude,
      double poiLongitude,
      String? poiAddress,
      double poiRating,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime? createdAt});
}

/// @nodoc
class __$$FavoritePOIImplCopyWithImpl<$Res>
    extends _$FavoritePOICopyWithImpl<$Res, _$FavoritePOIImpl>
    implements _$$FavoritePOIImplCopyWith<$Res> {
  __$$FavoritePOIImplCopyWithImpl(
      _$FavoritePOIImpl _value, $Res Function(_$FavoritePOIImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoritePOI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? poiId = null,
    Object? poiName = null,
    Object? poiDescription = null,
    Object? poiCategory = null,
    Object? poiLatitude = null,
    Object? poiLongitude = null,
    Object? poiAddress = freezed,
    Object? poiRating = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$FavoritePOIImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      poiId: null == poiId
          ? _value.poiId
          : poiId // ignore: cast_nullable_to_non_nullable
              as String,
      poiName: null == poiName
          ? _value.poiName
          : poiName // ignore: cast_nullable_to_non_nullable
              as String,
      poiDescription: null == poiDescription
          ? _value.poiDescription
          : poiDescription // ignore: cast_nullable_to_non_nullable
              as String,
      poiCategory: null == poiCategory
          ? _value.poiCategory
          : poiCategory // ignore: cast_nullable_to_non_nullable
              as String,
      poiLatitude: null == poiLatitude
          ? _value.poiLatitude
          : poiLatitude // ignore: cast_nullable_to_non_nullable
              as double,
      poiLongitude: null == poiLongitude
          ? _value.poiLongitude
          : poiLongitude // ignore: cast_nullable_to_non_nullable
              as double,
      poiAddress: freezed == poiAddress
          ? _value.poiAddress
          : poiAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      poiRating: null == poiRating
          ? _value.poiRating
          : poiRating // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FavoritePOIImpl implements _FavoritePOI {
  const _$FavoritePOIImpl(
      {required this.id,
      required this.userId,
      required this.poiId,
      required this.poiName,
      required this.poiDescription,
      required this.poiCategory,
      required this.poiLatitude,
      required this.poiLongitude,
      this.poiAddress,
      this.poiRating = 0.0,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      this.createdAt});

  factory _$FavoritePOIImpl.fromJson(Map<String, dynamic> json) =>
      _$$FavoritePOIImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String poiId;
  @override
  final String poiName;
  @override
  final String poiDescription;
  @override
  final String poiCategory;
  @override
  final double poiLatitude;
  @override
  final double poiLongitude;
  @override
  final String? poiAddress;
  @override
  @JsonKey()
  final double poiRating;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime? createdAt;

  @override
  String toString() {
    return 'FavoritePOI(id: $id, userId: $userId, poiId: $poiId, poiName: $poiName, poiDescription: $poiDescription, poiCategory: $poiCategory, poiLatitude: $poiLatitude, poiLongitude: $poiLongitude, poiAddress: $poiAddress, poiRating: $poiRating, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoritePOIImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.poiId, poiId) || other.poiId == poiId) &&
            (identical(other.poiName, poiName) || other.poiName == poiName) &&
            (identical(other.poiDescription, poiDescription) ||
                other.poiDescription == poiDescription) &&
            (identical(other.poiCategory, poiCategory) ||
                other.poiCategory == poiCategory) &&
            (identical(other.poiLatitude, poiLatitude) ||
                other.poiLatitude == poiLatitude) &&
            (identical(other.poiLongitude, poiLongitude) ||
                other.poiLongitude == poiLongitude) &&
            (identical(other.poiAddress, poiAddress) ||
                other.poiAddress == poiAddress) &&
            (identical(other.poiRating, poiRating) ||
                other.poiRating == poiRating) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      poiId,
      poiName,
      poiDescription,
      poiCategory,
      poiLatitude,
      poiLongitude,
      poiAddress,
      poiRating,
      createdAt);

  /// Create a copy of FavoritePOI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoritePOIImplCopyWith<_$FavoritePOIImpl> get copyWith =>
      __$$FavoritePOIImplCopyWithImpl<_$FavoritePOIImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FavoritePOIImplToJson(
      this,
    );
  }
}

abstract class _FavoritePOI implements FavoritePOI {
  const factory _FavoritePOI(
      {required final String id,
      required final String userId,
      required final String poiId,
      required final String poiName,
      required final String poiDescription,
      required final String poiCategory,
      required final double poiLatitude,
      required final double poiLongitude,
      final String? poiAddress,
      final double poiRating,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      final DateTime? createdAt}) = _$FavoritePOIImpl;

  factory _FavoritePOI.fromJson(Map<String, dynamic> json) =
      _$FavoritePOIImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get poiId;
  @override
  String get poiName;
  @override
  String get poiDescription;
  @override
  String get poiCategory;
  @override
  double get poiLatitude;
  @override
  double get poiLongitude;
  @override
  String? get poiAddress;
  @override
  double get poiRating;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime? get createdAt;

  /// Create a copy of FavoritePOI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoritePOIImplCopyWith<_$FavoritePOIImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
