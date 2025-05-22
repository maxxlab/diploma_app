// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RouteInfo _$RouteInfoFromJson(Map<String, dynamic> json) {
  return _RouteInfo.fromJson(json);
}

/// @nodoc
mixin _$RouteInfo {
  Map<String, dynamic> get geometry => throw _privateConstructorUsedError;
  List<RouteSegment> get segments => throw _privateConstructorUsedError;
  double get totalDistance => throw _privateConstructorUsedError;
  double get totalDuration => throw _privateConstructorUsedError;
  List<RoutePoint> get waypoints => throw _privateConstructorUsedError;

  /// Serializes this RouteInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RouteInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteInfoCopyWith<RouteInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteInfoCopyWith<$Res> {
  factory $RouteInfoCopyWith(RouteInfo value, $Res Function(RouteInfo) then) =
      _$RouteInfoCopyWithImpl<$Res, RouteInfo>;
  @useResult
  $Res call(
      {Map<String, dynamic> geometry,
      List<RouteSegment> segments,
      double totalDistance,
      double totalDuration,
      List<RoutePoint> waypoints});
}

/// @nodoc
class _$RouteInfoCopyWithImpl<$Res, $Val extends RouteInfo>
    implements $RouteInfoCopyWith<$Res> {
  _$RouteInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geometry = null,
    Object? segments = null,
    Object? totalDistance = null,
    Object? totalDuration = null,
    Object? waypoints = null,
  }) {
    return _then(_value.copyWith(
      geometry: null == geometry
          ? _value.geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      segments: null == segments
          ? _value.segments
          : segments // ignore: cast_nullable_to_non_nullable
              as List<RouteSegment>,
      totalDistance: null == totalDistance
          ? _value.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as double,
      totalDuration: null == totalDuration
          ? _value.totalDuration
          : totalDuration // ignore: cast_nullable_to_non_nullable
              as double,
      waypoints: null == waypoints
          ? _value.waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as List<RoutePoint>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RouteInfoImplCopyWith<$Res>
    implements $RouteInfoCopyWith<$Res> {
  factory _$$RouteInfoImplCopyWith(
          _$RouteInfoImpl value, $Res Function(_$RouteInfoImpl) then) =
      __$$RouteInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, dynamic> geometry,
      List<RouteSegment> segments,
      double totalDistance,
      double totalDuration,
      List<RoutePoint> waypoints});
}

/// @nodoc
class __$$RouteInfoImplCopyWithImpl<$Res>
    extends _$RouteInfoCopyWithImpl<$Res, _$RouteInfoImpl>
    implements _$$RouteInfoImplCopyWith<$Res> {
  __$$RouteInfoImplCopyWithImpl(
      _$RouteInfoImpl _value, $Res Function(_$RouteInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of RouteInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geometry = null,
    Object? segments = null,
    Object? totalDistance = null,
    Object? totalDuration = null,
    Object? waypoints = null,
  }) {
    return _then(_$RouteInfoImpl(
      geometry: null == geometry
          ? _value._geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      segments: null == segments
          ? _value._segments
          : segments // ignore: cast_nullable_to_non_nullable
              as List<RouteSegment>,
      totalDistance: null == totalDistance
          ? _value.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as double,
      totalDuration: null == totalDuration
          ? _value.totalDuration
          : totalDuration // ignore: cast_nullable_to_non_nullable
              as double,
      waypoints: null == waypoints
          ? _value._waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as List<RoutePoint>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteInfoImpl implements _RouteInfo {
  const _$RouteInfoImpl(
      {required final Map<String, dynamic> geometry,
      required final List<RouteSegment> segments,
      required this.totalDistance,
      required this.totalDuration,
      required final List<RoutePoint> waypoints})
      : _geometry = geometry,
        _segments = segments,
        _waypoints = waypoints;

  factory _$RouteInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteInfoImplFromJson(json);

  final Map<String, dynamic> _geometry;
  @override
  Map<String, dynamic> get geometry {
    if (_geometry is EqualUnmodifiableMapView) return _geometry;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_geometry);
  }

  final List<RouteSegment> _segments;
  @override
  List<RouteSegment> get segments {
    if (_segments is EqualUnmodifiableListView) return _segments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_segments);
  }

  @override
  final double totalDistance;
  @override
  final double totalDuration;
  final List<RoutePoint> _waypoints;
  @override
  List<RoutePoint> get waypoints {
    if (_waypoints is EqualUnmodifiableListView) return _waypoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_waypoints);
  }

  @override
  String toString() {
    return 'RouteInfo(geometry: $geometry, segments: $segments, totalDistance: $totalDistance, totalDuration: $totalDuration, waypoints: $waypoints)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteInfoImpl &&
            const DeepCollectionEquality().equals(other._geometry, _geometry) &&
            const DeepCollectionEquality().equals(other._segments, _segments) &&
            (identical(other.totalDistance, totalDistance) ||
                other.totalDistance == totalDistance) &&
            (identical(other.totalDuration, totalDuration) ||
                other.totalDuration == totalDuration) &&
            const DeepCollectionEquality()
                .equals(other._waypoints, _waypoints));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_geometry),
      const DeepCollectionEquality().hash(_segments),
      totalDistance,
      totalDuration,
      const DeepCollectionEquality().hash(_waypoints));

  /// Create a copy of RouteInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteInfoImplCopyWith<_$RouteInfoImpl> get copyWith =>
      __$$RouteInfoImplCopyWithImpl<_$RouteInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteInfoImplToJson(
      this,
    );
  }
}

abstract class _RouteInfo implements RouteInfo {
  const factory _RouteInfo(
      {required final Map<String, dynamic> geometry,
      required final List<RouteSegment> segments,
      required final double totalDistance,
      required final double totalDuration,
      required final List<RoutePoint> waypoints}) = _$RouteInfoImpl;

  factory _RouteInfo.fromJson(Map<String, dynamic> json) =
      _$RouteInfoImpl.fromJson;

  @override
  Map<String, dynamic> get geometry;
  @override
  List<RouteSegment> get segments;
  @override
  double get totalDistance;
  @override
  double get totalDuration;
  @override
  List<RoutePoint> get waypoints;

  /// Create a copy of RouteInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteInfoImplCopyWith<_$RouteInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RouteSegment _$RouteSegmentFromJson(Map<String, dynamic> json) {
  return _RouteSegment.fromJson(json);
}

/// @nodoc
mixin _$RouteSegment {
  String get fromPoi => throw _privateConstructorUsedError;
  String get toPoi => throw _privateConstructorUsedError;
  double get distance => throw _privateConstructorUsedError;
  double get duration => throw _privateConstructorUsedError;

  /// Serializes this RouteSegment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RouteSegment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteSegmentCopyWith<RouteSegment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteSegmentCopyWith<$Res> {
  factory $RouteSegmentCopyWith(
          RouteSegment value, $Res Function(RouteSegment) then) =
      _$RouteSegmentCopyWithImpl<$Res, RouteSegment>;
  @useResult
  $Res call({String fromPoi, String toPoi, double distance, double duration});
}

/// @nodoc
class _$RouteSegmentCopyWithImpl<$Res, $Val extends RouteSegment>
    implements $RouteSegmentCopyWith<$Res> {
  _$RouteSegmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteSegment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromPoi = null,
    Object? toPoi = null,
    Object? distance = null,
    Object? duration = null,
  }) {
    return _then(_value.copyWith(
      fromPoi: null == fromPoi
          ? _value.fromPoi
          : fromPoi // ignore: cast_nullable_to_non_nullable
              as String,
      toPoi: null == toPoi
          ? _value.toPoi
          : toPoi // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RouteSegmentImplCopyWith<$Res>
    implements $RouteSegmentCopyWith<$Res> {
  factory _$$RouteSegmentImplCopyWith(
          _$RouteSegmentImpl value, $Res Function(_$RouteSegmentImpl) then) =
      __$$RouteSegmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String fromPoi, String toPoi, double distance, double duration});
}

/// @nodoc
class __$$RouteSegmentImplCopyWithImpl<$Res>
    extends _$RouteSegmentCopyWithImpl<$Res, _$RouteSegmentImpl>
    implements _$$RouteSegmentImplCopyWith<$Res> {
  __$$RouteSegmentImplCopyWithImpl(
      _$RouteSegmentImpl _value, $Res Function(_$RouteSegmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of RouteSegment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromPoi = null,
    Object? toPoi = null,
    Object? distance = null,
    Object? duration = null,
  }) {
    return _then(_$RouteSegmentImpl(
      fromPoi: null == fromPoi
          ? _value.fromPoi
          : fromPoi // ignore: cast_nullable_to_non_nullable
              as String,
      toPoi: null == toPoi
          ? _value.toPoi
          : toPoi // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteSegmentImpl implements _RouteSegment {
  const _$RouteSegmentImpl(
      {required this.fromPoi,
      required this.toPoi,
      required this.distance,
      required this.duration});

  factory _$RouteSegmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteSegmentImplFromJson(json);

  @override
  final String fromPoi;
  @override
  final String toPoi;
  @override
  final double distance;
  @override
  final double duration;

  @override
  String toString() {
    return 'RouteSegment(fromPoi: $fromPoi, toPoi: $toPoi, distance: $distance, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteSegmentImpl &&
            (identical(other.fromPoi, fromPoi) || other.fromPoi == fromPoi) &&
            (identical(other.toPoi, toPoi) || other.toPoi == toPoi) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, fromPoi, toPoi, distance, duration);

  /// Create a copy of RouteSegment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteSegmentImplCopyWith<_$RouteSegmentImpl> get copyWith =>
      __$$RouteSegmentImplCopyWithImpl<_$RouteSegmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteSegmentImplToJson(
      this,
    );
  }
}

abstract class _RouteSegment implements RouteSegment {
  const factory _RouteSegment(
      {required final String fromPoi,
      required final String toPoi,
      required final double distance,
      required final double duration}) = _$RouteSegmentImpl;

  factory _RouteSegment.fromJson(Map<String, dynamic> json) =
      _$RouteSegmentImpl.fromJson;

  @override
  String get fromPoi;
  @override
  String get toPoi;
  @override
  double get distance;
  @override
  double get duration;

  /// Create a copy of RouteSegment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteSegmentImplCopyWith<_$RouteSegmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RoutePoint _$RoutePointFromJson(Map<String, dynamic> json) {
  return _RoutePoint.fromJson(json);
}

/// @nodoc
mixin _$RoutePoint {
  String get poiId => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  /// Serializes this RoutePoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoutePoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoutePointCopyWith<RoutePoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoutePointCopyWith<$Res> {
  factory $RoutePointCopyWith(
          RoutePoint value, $Res Function(RoutePoint) then) =
      _$RoutePointCopyWithImpl<$Res, RoutePoint>;
  @useResult
  $Res call({String poiId, double latitude, double longitude});
}

/// @nodoc
class _$RoutePointCopyWithImpl<$Res, $Val extends RoutePoint>
    implements $RoutePointCopyWith<$Res> {
  _$RoutePointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoutePoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poiId = null,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_value.copyWith(
      poiId: null == poiId
          ? _value.poiId
          : poiId // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoutePointImplCopyWith<$Res>
    implements $RoutePointCopyWith<$Res> {
  factory _$$RoutePointImplCopyWith(
          _$RoutePointImpl value, $Res Function(_$RoutePointImpl) then) =
      __$$RoutePointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String poiId, double latitude, double longitude});
}

/// @nodoc
class __$$RoutePointImplCopyWithImpl<$Res>
    extends _$RoutePointCopyWithImpl<$Res, _$RoutePointImpl>
    implements _$$RoutePointImplCopyWith<$Res> {
  __$$RoutePointImplCopyWithImpl(
      _$RoutePointImpl _value, $Res Function(_$RoutePointImpl) _then)
      : super(_value, _then);

  /// Create a copy of RoutePoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poiId = null,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$RoutePointImpl(
      poiId: null == poiId
          ? _value.poiId
          : poiId // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoutePointImpl implements _RoutePoint {
  const _$RoutePointImpl(
      {required this.poiId, required this.latitude, required this.longitude});

  factory _$RoutePointImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoutePointImplFromJson(json);

  @override
  final String poiId;
  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'RoutePoint(poiId: $poiId, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutePointImpl &&
            (identical(other.poiId, poiId) || other.poiId == poiId) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, poiId, latitude, longitude);

  /// Create a copy of RoutePoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutePointImplCopyWith<_$RoutePointImpl> get copyWith =>
      __$$RoutePointImplCopyWithImpl<_$RoutePointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoutePointImplToJson(
      this,
    );
  }
}

abstract class _RoutePoint implements RoutePoint {
  const factory _RoutePoint(
      {required final String poiId,
      required final double latitude,
      required final double longitude}) = _$RoutePointImpl;

  factory _RoutePoint.fromJson(Map<String, dynamic> json) =
      _$RoutePointImpl.fromJson;

  @override
  String get poiId;
  @override
  double get latitude;
  @override
  double get longitude;

  /// Create a copy of RoutePoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoutePointImplCopyWith<_$RoutePointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
