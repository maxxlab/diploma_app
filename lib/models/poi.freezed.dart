// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poi.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

POI _$POIFromJson(Map<String, dynamic> json) {
  return _POI.fromJson(json);
}

/// @nodoc
mixin _$POI {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _geoPointFromJson, toJson: _geoPointToJson)
  GeoPoint get location =>
      throw _privateConstructorUsedError; // Use Firebase GeoPoint
  String? get address => throw _privateConstructorUsedError;
  Map<String, String>? get contactInfo => throw _privateConstructorUsedError;
  Map<String, dynamic>? get workingHours => throw _privateConstructorUsedError;
  List<String>? get photos => throw _privateConstructorUsedError;
  double get averageRating => throw _privateConstructorUsedError;
  String? get priceCategory => throw _privateConstructorUsedError;
  bool get isAccessible => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError;
  Map<String, dynamic> get additionalData => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this POI to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of POI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $POICopyWith<POI> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $POICopyWith<$Res> {
  factory $POICopyWith(POI value, $Res Function(POI) then) =
      _$POICopyWithImpl<$Res, POI>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String category,
      @JsonKey(fromJson: _geoPointFromJson, toJson: _geoPointToJson)
      GeoPoint location,
      String? address,
      Map<String, String>? contactInfo,
      Map<String, dynamic>? workingHours,
      List<String>? photos,
      double averageRating,
      String? priceCategory,
      bool isAccessible,
      String? region,
      Map<String, dynamic> additionalData,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime? createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime? updatedAt});
}

/// @nodoc
class _$POICopyWithImpl<$Res, $Val extends POI> implements $POICopyWith<$Res> {
  _$POICopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of POI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? category = null,
    Object? location = null,
    Object? address = freezed,
    Object? contactInfo = freezed,
    Object? workingHours = freezed,
    Object? photos = freezed,
    Object? averageRating = null,
    Object? priceCategory = freezed,
    Object? isAccessible = null,
    Object? region = freezed,
    Object? additionalData = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      contactInfo: freezed == contactInfo
          ? _value.contactInfo
          : contactInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      workingHours: freezed == workingHours
          ? _value.workingHours
          : workingHours // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      photos: freezed == photos
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      priceCategory: freezed == priceCategory
          ? _value.priceCategory
          : priceCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      isAccessible: null == isAccessible
          ? _value.isAccessible
          : isAccessible // ignore: cast_nullable_to_non_nullable
              as bool,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalData: null == additionalData
          ? _value.additionalData
          : additionalData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$POIImplCopyWith<$Res> implements $POICopyWith<$Res> {
  factory _$$POIImplCopyWith(_$POIImpl value, $Res Function(_$POIImpl) then) =
      __$$POIImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String category,
      @JsonKey(fromJson: _geoPointFromJson, toJson: _geoPointToJson)
      GeoPoint location,
      String? address,
      Map<String, String>? contactInfo,
      Map<String, dynamic>? workingHours,
      List<String>? photos,
      double averageRating,
      String? priceCategory,
      bool isAccessible,
      String? region,
      Map<String, dynamic> additionalData,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime? createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime? updatedAt});
}

/// @nodoc
class __$$POIImplCopyWithImpl<$Res> extends _$POICopyWithImpl<$Res, _$POIImpl>
    implements _$$POIImplCopyWith<$Res> {
  __$$POIImplCopyWithImpl(_$POIImpl _value, $Res Function(_$POIImpl) _then)
      : super(_value, _then);

  /// Create a copy of POI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? category = null,
    Object? location = null,
    Object? address = freezed,
    Object? contactInfo = freezed,
    Object? workingHours = freezed,
    Object? photos = freezed,
    Object? averageRating = null,
    Object? priceCategory = freezed,
    Object? isAccessible = null,
    Object? region = freezed,
    Object? additionalData = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$POIImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      contactInfo: freezed == contactInfo
          ? _value._contactInfo
          : contactInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      workingHours: freezed == workingHours
          ? _value._workingHours
          : workingHours // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      photos: freezed == photos
          ? _value._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      priceCategory: freezed == priceCategory
          ? _value.priceCategory
          : priceCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      isAccessible: null == isAccessible
          ? _value.isAccessible
          : isAccessible // ignore: cast_nullable_to_non_nullable
              as bool,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalData: null == additionalData
          ? _value._additionalData
          : additionalData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$POIImpl implements _POI {
  const _$POIImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.category,
      @JsonKey(fromJson: _geoPointFromJson, toJson: _geoPointToJson)
      required this.location,
      this.address,
      final Map<String, String>? contactInfo,
      final Map<String, dynamic>? workingHours,
      final List<String>? photos,
      this.averageRating = 0.0,
      this.priceCategory,
      this.isAccessible = false,
      this.region,
      final Map<String, dynamic> additionalData = const {},
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      this.createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      this.updatedAt})
      : _contactInfo = contactInfo,
        _workingHours = workingHours,
        _photos = photos,
        _additionalData = additionalData;

  factory _$POIImpl.fromJson(Map<String, dynamic> json) =>
      _$$POIImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String category;
  @override
  @JsonKey(fromJson: _geoPointFromJson, toJson: _geoPointToJson)
  final GeoPoint location;
// Use Firebase GeoPoint
  @override
  final String? address;
  final Map<String, String>? _contactInfo;
  @override
  Map<String, String>? get contactInfo {
    final value = _contactInfo;
    if (value == null) return null;
    if (_contactInfo is EqualUnmodifiableMapView) return _contactInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _workingHours;
  @override
  Map<String, dynamic>? get workingHours {
    final value = _workingHours;
    if (value == null) return null;
    if (_workingHours is EqualUnmodifiableMapView) return _workingHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String>? _photos;
  @override
  List<String>? get photos {
    final value = _photos;
    if (value == null) return null;
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final double averageRating;
  @override
  final String? priceCategory;
  @override
  @JsonKey()
  final bool isAccessible;
  @override
  final String? region;
  final Map<String, dynamic> _additionalData;
  @override
  @JsonKey()
  Map<String, dynamic> get additionalData {
    if (_additionalData is EqualUnmodifiableMapView) return _additionalData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_additionalData);
  }

  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime? createdAt;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'POI(id: $id, name: $name, description: $description, category: $category, location: $location, address: $address, contactInfo: $contactInfo, workingHours: $workingHours, photos: $photos, averageRating: $averageRating, priceCategory: $priceCategory, isAccessible: $isAccessible, region: $region, additionalData: $additionalData, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$POIImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality()
                .equals(other._contactInfo, _contactInfo) &&
            const DeepCollectionEquality()
                .equals(other._workingHours, _workingHours) &&
            const DeepCollectionEquality().equals(other._photos, _photos) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.priceCategory, priceCategory) ||
                other.priceCategory == priceCategory) &&
            (identical(other.isAccessible, isAccessible) ||
                other.isAccessible == isAccessible) &&
            (identical(other.region, region) || other.region == region) &&
            const DeepCollectionEquality()
                .equals(other._additionalData, _additionalData) &&
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
      name,
      description,
      category,
      location,
      address,
      const DeepCollectionEquality().hash(_contactInfo),
      const DeepCollectionEquality().hash(_workingHours),
      const DeepCollectionEquality().hash(_photos),
      averageRating,
      priceCategory,
      isAccessible,
      region,
      const DeepCollectionEquality().hash(_additionalData),
      createdAt,
      updatedAt);

  /// Create a copy of POI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$POIImplCopyWith<_$POIImpl> get copyWith =>
      __$$POIImplCopyWithImpl<_$POIImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$POIImplToJson(
      this,
    );
  }
}

abstract class _POI implements POI {
  const factory _POI(
      {required final String id,
      required final String name,
      required final String description,
      required final String category,
      @JsonKey(fromJson: _geoPointFromJson, toJson: _geoPointToJson)
      required final GeoPoint location,
      final String? address,
      final Map<String, String>? contactInfo,
      final Map<String, dynamic>? workingHours,
      final List<String>? photos,
      final double averageRating,
      final String? priceCategory,
      final bool isAccessible,
      final String? region,
      final Map<String, dynamic> additionalData,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      final DateTime? createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      final DateTime? updatedAt}) = _$POIImpl;

  factory _POI.fromJson(Map<String, dynamic> json) = _$POIImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get category;
  @override
  @JsonKey(fromJson: _geoPointFromJson, toJson: _geoPointToJson)
  GeoPoint get location; // Use Firebase GeoPoint
  @override
  String? get address;
  @override
  Map<String, String>? get contactInfo;
  @override
  Map<String, dynamic>? get workingHours;
  @override
  List<String>? get photos;
  @override
  double get averageRating;
  @override
  String? get priceCategory;
  @override
  bool get isAccessible;
  @override
  String? get region;
  @override
  Map<String, dynamic> get additionalData;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime? get createdAt;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime? get updatedAt;

  /// Create a copy of POI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$POIImplCopyWith<_$POIImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
