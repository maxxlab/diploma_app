// lib/models/route_info.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_info.freezed.dart';
part 'route_info.g.dart';

@freezed
class RouteInfo with _$RouteInfo {
  const factory RouteInfo({
    required Map<String, dynamic> geometry,
    required List<RouteSegment> segments,
    required double totalDistance,
    required double totalDuration,
    required List<RoutePoint> waypoints,
  }) = _RouteInfo;

  factory RouteInfo.fromJson(Map<String, dynamic> json) => _$RouteInfoFromJson(json);
}

@freezed
class RouteSegment with _$RouteSegment {
  const factory RouteSegment({
    required String fromPoi,
    required String toPoi,
    required double distance,
    required double duration,
  }) = _RouteSegment;

  factory RouteSegment.fromJson(Map<String, dynamic> json) => _$RouteSegmentFromJson(json);
}

@freezed
class RoutePoint with _$RoutePoint {
  const factory RoutePoint({
    required String poiId,
    required double latitude,
    required double longitude,
  }) = _RoutePoint;

  factory RoutePoint.fromJson(Map<String, dynamic> json) => _$RoutePointFromJson(json);
}