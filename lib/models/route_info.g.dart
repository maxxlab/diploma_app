// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RouteInfoImpl _$$RouteInfoImplFromJson(Map<String, dynamic> json) =>
    _$RouteInfoImpl(
      geometry: json['geometry'] as Map<String, dynamic>,
      segments: (json['segments'] as List<dynamic>)
          .map((e) => RouteSegment.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDistance: (json['totalDistance'] as num).toDouble(),
      totalDuration: (json['totalDuration'] as num).toDouble(),
      waypoints: (json['waypoints'] as List<dynamic>)
          .map((e) => RoutePoint.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RouteInfoImplToJson(_$RouteInfoImpl instance) =>
    <String, dynamic>{
      'geometry': instance.geometry,
      'segments': instance.segments,
      'totalDistance': instance.totalDistance,
      'totalDuration': instance.totalDuration,
      'waypoints': instance.waypoints,
    };

_$RouteSegmentImpl _$$RouteSegmentImplFromJson(Map<String, dynamic> json) =>
    _$RouteSegmentImpl(
      fromPoi: json['fromPoi'] as String,
      toPoi: json['toPoi'] as String,
      distance: (json['distance'] as num).toDouble(),
      duration: (json['duration'] as num).toDouble(),
    );

Map<String, dynamic> _$$RouteSegmentImplToJson(_$RouteSegmentImpl instance) =>
    <String, dynamic>{
      'fromPoi': instance.fromPoi,
      'toPoi': instance.toPoi,
      'distance': instance.distance,
      'duration': instance.duration,
    };

_$RoutePointImpl _$$RoutePointImplFromJson(Map<String, dynamic> json) =>
    _$RoutePointImpl(
      poiId: json['poiId'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$$RoutePointImplToJson(_$RoutePointImpl instance) =>
    <String, dynamic>{
      'poiId': instance.poiId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
