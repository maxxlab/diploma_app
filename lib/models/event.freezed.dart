// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Event _$EventFromJson(Map<String, dynamic> json) {
  return _Event.fromJson(json);
}

/// @nodoc
mixin _$Event {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Map<String, dynamic> get location => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJsonNonNull, toJson: _timestampToJson)
  DateTime get startTime => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJsonNonNull, toJson: _timestampToJson)
  DateTime get endTime => throw _privateConstructorUsedError;
  String? get organizer => throw _privateConstructorUsedError;
  String? get priceInfo => throw _privateConstructorUsedError;
  List<String> get photos => throw _privateConstructorUsedError;
  Map<String, dynamic> get additionalData => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Event to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventCopyWith<Event> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) then) =
      _$EventCopyWithImpl<$Res, Event>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      Map<String, dynamic> location,
      String category,
      @JsonKey(fromJson: _timestampFromJsonNonNull, toJson: _timestampToJson)
      DateTime startTime,
      @JsonKey(fromJson: _timestampFromJsonNonNull, toJson: _timestampToJson)
      DateTime endTime,
      String? organizer,
      String? priceInfo,
      List<String> photos,
      Map<String, dynamic> additionalData,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime? createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime? updatedAt});
}

/// @nodoc
class _$EventCopyWithImpl<$Res, $Val extends Event>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? location = null,
    Object? category = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? organizer = freezed,
    Object? priceInfo = freezed,
    Object? photos = null,
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
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      organizer: freezed == organizer
          ? _value.organizer
          : organizer // ignore: cast_nullable_to_non_nullable
              as String?,
      priceInfo: freezed == priceInfo
          ? _value.priceInfo
          : priceInfo // ignore: cast_nullable_to_non_nullable
              as String?,
      photos: null == photos
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
abstract class _$$EventImplCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$$EventImplCopyWith(
          _$EventImpl value, $Res Function(_$EventImpl) then) =
      __$$EventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      Map<String, dynamic> location,
      String category,
      @JsonKey(fromJson: _timestampFromJsonNonNull, toJson: _timestampToJson)
      DateTime startTime,
      @JsonKey(fromJson: _timestampFromJsonNonNull, toJson: _timestampToJson)
      DateTime endTime,
      String? organizer,
      String? priceInfo,
      List<String> photos,
      Map<String, dynamic> additionalData,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime? createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime? updatedAt});
}

/// @nodoc
class __$$EventImplCopyWithImpl<$Res>
    extends _$EventCopyWithImpl<$Res, _$EventImpl>
    implements _$$EventImplCopyWith<$Res> {
  __$$EventImplCopyWithImpl(
      _$EventImpl _value, $Res Function(_$EventImpl) _then)
      : super(_value, _then);

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? location = null,
    Object? category = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? organizer = freezed,
    Object? priceInfo = freezed,
    Object? photos = null,
    Object? additionalData = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$EventImpl(
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
      location: null == location
          ? _value._location
          : location // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      organizer: freezed == organizer
          ? _value.organizer
          : organizer // ignore: cast_nullable_to_non_nullable
              as String?,
      priceInfo: freezed == priceInfo
          ? _value.priceInfo
          : priceInfo // ignore: cast_nullable_to_non_nullable
              as String?,
      photos: null == photos
          ? _value._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
class _$EventImpl implements _Event {
  const _$EventImpl(
      {required this.id,
      required this.name,
      required this.description,
      required final Map<String, dynamic> location,
      required this.category,
      @JsonKey(fromJson: _timestampFromJsonNonNull, toJson: _timestampToJson)
      required this.startTime,
      @JsonKey(fromJson: _timestampFromJsonNonNull, toJson: _timestampToJson)
      required this.endTime,
      this.organizer,
      this.priceInfo,
      final List<String> photos = const [],
      final Map<String, dynamic> additionalData = const {},
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      this.createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      this.updatedAt})
      : _location = location,
        _photos = photos,
        _additionalData = additionalData;

  factory _$EventImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  final Map<String, dynamic> _location;
  @override
  Map<String, dynamic> get location {
    if (_location is EqualUnmodifiableMapView) return _location;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_location);
  }

  @override
  final String category;
  @override
  @JsonKey(fromJson: _timestampFromJsonNonNull, toJson: _timestampToJson)
  final DateTime startTime;
  @override
  @JsonKey(fromJson: _timestampFromJsonNonNull, toJson: _timestampToJson)
  final DateTime endTime;
  @override
  final String? organizer;
  @override
  final String? priceInfo;
  final List<String> _photos;
  @override
  @JsonKey()
  List<String> get photos {
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photos);
  }

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
    return 'Event(id: $id, name: $name, description: $description, location: $location, category: $category, startTime: $startTime, endTime: $endTime, organizer: $organizer, priceInfo: $priceInfo, photos: $photos, additionalData: $additionalData, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._location, _location) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.organizer, organizer) ||
                other.organizer == organizer) &&
            (identical(other.priceInfo, priceInfo) ||
                other.priceInfo == priceInfo) &&
            const DeepCollectionEquality().equals(other._photos, _photos) &&
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
      const DeepCollectionEquality().hash(_location),
      category,
      startTime,
      endTime,
      organizer,
      priceInfo,
      const DeepCollectionEquality().hash(_photos),
      const DeepCollectionEquality().hash(_additionalData),
      createdAt,
      updatedAt);

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      __$$EventImplCopyWithImpl<_$EventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventImplToJson(
      this,
    );
  }
}

abstract class _Event implements Event {
  const factory _Event(
      {required final String id,
      required final String name,
      required final String description,
      required final Map<String, dynamic> location,
      required final String category,
      @JsonKey(fromJson: _timestampFromJsonNonNull, toJson: _timestampToJson)
      required final DateTime startTime,
      @JsonKey(fromJson: _timestampFromJsonNonNull, toJson: _timestampToJson)
      required final DateTime endTime,
      final String? organizer,
      final String? priceInfo,
      final List<String> photos,
      final Map<String, dynamic> additionalData,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      final DateTime? createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      final DateTime? updatedAt}) = _$EventImpl;

  factory _Event.fromJson(Map<String, dynamic> json) = _$EventImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  Map<String, dynamic> get location;
  @override
  String get category;
  @override
  @JsonKey(fromJson: _timestampFromJsonNonNull, toJson: _timestampToJson)
  DateTime get startTime;
  @override
  @JsonKey(fromJson: _timestampFromJsonNonNull, toJson: _timestampToJson)
  DateTime get endTime;
  @override
  String? get organizer;
  @override
  String? get priceInfo;
  @override
  List<String> get photos;
  @override
  Map<String, dynamic> get additionalData;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime? get createdAt;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime? get updatedAt;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
