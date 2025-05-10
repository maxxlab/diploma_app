// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cached_region.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CachedRegion _$CachedRegionFromJson(Map<String, dynamic> json) {
  return _CachedRegion.fromJson(json);
}

/// @nodoc
mixin _$CachedRegion {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Map<String, dynamic> get centerCoordinates =>
      throw _privateConstructorUsedError;
  double get radius => throw _privateConstructorUsedError;
  List<String> get cachedCategories => throw _privateConstructorUsedError;
  int get detailLevel => throw _privateConstructorUsedError;
  int get sizeBytes => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime? get lastSynced => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this CachedRegion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CachedRegion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CachedRegionCopyWith<CachedRegion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CachedRegionCopyWith<$Res> {
  factory $CachedRegionCopyWith(
          CachedRegion value, $Res Function(CachedRegion) then) =
      _$CachedRegionCopyWithImpl<$Res, CachedRegion>;
  @useResult
  $Res call(
      {String id,
      String name,
      Map<String, dynamic> centerCoordinates,
      double radius,
      List<String> cachedCategories,
      int detailLevel,
      int sizeBytes,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime? lastSynced,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime? createdAt});
}

/// @nodoc
class _$CachedRegionCopyWithImpl<$Res, $Val extends CachedRegion>
    implements $CachedRegionCopyWith<$Res> {
  _$CachedRegionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CachedRegion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? centerCoordinates = null,
    Object? radius = null,
    Object? cachedCategories = null,
    Object? detailLevel = null,
    Object? sizeBytes = null,
    Object? lastSynced = freezed,
    Object? createdAt = freezed,
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
      centerCoordinates: null == centerCoordinates
          ? _value.centerCoordinates
          : centerCoordinates // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      radius: null == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as double,
      cachedCategories: null == cachedCategories
          ? _value.cachedCategories
          : cachedCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      detailLevel: null == detailLevel
          ? _value.detailLevel
          : detailLevel // ignore: cast_nullable_to_non_nullable
              as int,
      sizeBytes: null == sizeBytes
          ? _value.sizeBytes
          : sizeBytes // ignore: cast_nullable_to_non_nullable
              as int,
      lastSynced: freezed == lastSynced
          ? _value.lastSynced
          : lastSynced // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CachedRegionImplCopyWith<$Res>
    implements $CachedRegionCopyWith<$Res> {
  factory _$$CachedRegionImplCopyWith(
          _$CachedRegionImpl value, $Res Function(_$CachedRegionImpl) then) =
      __$$CachedRegionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      Map<String, dynamic> centerCoordinates,
      double radius,
      List<String> cachedCategories,
      int detailLevel,
      int sizeBytes,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime? lastSynced,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime? createdAt});
}

/// @nodoc
class __$$CachedRegionImplCopyWithImpl<$Res>
    extends _$CachedRegionCopyWithImpl<$Res, _$CachedRegionImpl>
    implements _$$CachedRegionImplCopyWith<$Res> {
  __$$CachedRegionImplCopyWithImpl(
      _$CachedRegionImpl _value, $Res Function(_$CachedRegionImpl) _then)
      : super(_value, _then);

  /// Create a copy of CachedRegion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? centerCoordinates = null,
    Object? radius = null,
    Object? cachedCategories = null,
    Object? detailLevel = null,
    Object? sizeBytes = null,
    Object? lastSynced = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$CachedRegionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      centerCoordinates: null == centerCoordinates
          ? _value._centerCoordinates
          : centerCoordinates // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      radius: null == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as double,
      cachedCategories: null == cachedCategories
          ? _value._cachedCategories
          : cachedCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      detailLevel: null == detailLevel
          ? _value.detailLevel
          : detailLevel // ignore: cast_nullable_to_non_nullable
              as int,
      sizeBytes: null == sizeBytes
          ? _value.sizeBytes
          : sizeBytes // ignore: cast_nullable_to_non_nullable
              as int,
      lastSynced: freezed == lastSynced
          ? _value.lastSynced
          : lastSynced // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CachedRegionImpl implements _CachedRegion {
  const _$CachedRegionImpl(
      {required this.id,
      required this.name,
      required final Map<String, dynamic> centerCoordinates,
      required this.radius,
      final List<String> cachedCategories = const [],
      this.detailLevel = 1,
      this.sizeBytes = 0,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      this.lastSynced,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      this.createdAt})
      : _centerCoordinates = centerCoordinates,
        _cachedCategories = cachedCategories;

  factory _$CachedRegionImpl.fromJson(Map<String, dynamic> json) =>
      _$$CachedRegionImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final Map<String, dynamic> _centerCoordinates;
  @override
  Map<String, dynamic> get centerCoordinates {
    if (_centerCoordinates is EqualUnmodifiableMapView)
      return _centerCoordinates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_centerCoordinates);
  }

  @override
  final double radius;
  final List<String> _cachedCategories;
  @override
  @JsonKey()
  List<String> get cachedCategories {
    if (_cachedCategories is EqualUnmodifiableListView)
      return _cachedCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cachedCategories);
  }

  @override
  @JsonKey()
  final int detailLevel;
  @override
  @JsonKey()
  final int sizeBytes;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime? lastSynced;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime? createdAt;

  @override
  String toString() {
    return 'CachedRegion(id: $id, name: $name, centerCoordinates: $centerCoordinates, radius: $radius, cachedCategories: $cachedCategories, detailLevel: $detailLevel, sizeBytes: $sizeBytes, lastSynced: $lastSynced, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CachedRegionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._centerCoordinates, _centerCoordinates) &&
            (identical(other.radius, radius) || other.radius == radius) &&
            const DeepCollectionEquality()
                .equals(other._cachedCategories, _cachedCategories) &&
            (identical(other.detailLevel, detailLevel) ||
                other.detailLevel == detailLevel) &&
            (identical(other.sizeBytes, sizeBytes) ||
                other.sizeBytes == sizeBytes) &&
            (identical(other.lastSynced, lastSynced) ||
                other.lastSynced == lastSynced) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(_centerCoordinates),
      radius,
      const DeepCollectionEquality().hash(_cachedCategories),
      detailLevel,
      sizeBytes,
      lastSynced,
      createdAt);

  /// Create a copy of CachedRegion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CachedRegionImplCopyWith<_$CachedRegionImpl> get copyWith =>
      __$$CachedRegionImplCopyWithImpl<_$CachedRegionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CachedRegionImplToJson(
      this,
    );
  }
}

abstract class _CachedRegion implements CachedRegion {
  const factory _CachedRegion(
      {required final String id,
      required final String name,
      required final Map<String, dynamic> centerCoordinates,
      required final double radius,
      final List<String> cachedCategories,
      final int detailLevel,
      final int sizeBytes,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      final DateTime? lastSynced,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      final DateTime? createdAt}) = _$CachedRegionImpl;

  factory _CachedRegion.fromJson(Map<String, dynamic> json) =
      _$CachedRegionImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  Map<String, dynamic> get centerCoordinates;
  @override
  double get radius;
  @override
  List<String> get cachedCategories;
  @override
  int get detailLevel;
  @override
  int get sizeBytes;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime? get lastSynced;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime? get createdAt;

  /// Create a copy of CachedRegion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CachedRegionImplCopyWith<_$CachedRegionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
