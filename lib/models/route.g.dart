// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TouristRouteImpl _$$TouristRouteImplFromJson(Map<String, dynamic> json) =>
    _$TouristRouteImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      creatorId: json['creatorId'] as String,
      points: (json['points'] as List<dynamic>?)
              ?.map((e) => RoutePoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      estimatedTimeMinutes:
          (json['estimatedTimeMinutes'] as num?)?.toInt() ?? 0,
      distanceKm: (json['distanceKm'] as num?)?.toDouble() ?? 0.0,
      isPublic: json['isPublic'] as bool? ?? true,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      additionalData:
          json['additionalData'] as Map<String, dynamic>? ?? const {},
      createdAt: _timestampFromJson(json['createdAt']),
      updatedAt: _timestampFromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$TouristRouteImplToJson(_$TouristRouteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'creatorId': instance.creatorId,
      'points': instance.points,
      'estimatedTimeMinutes': instance.estimatedTimeMinutes,
      'distanceKm': instance.distanceKm,
      'isPublic': instance.isPublic,
      'tags': instance.tags,
      'additionalData': instance.additionalData,
      'createdAt': _timestampToJson(instance.createdAt),
      'updatedAt': _timestampToJson(instance.updatedAt),
    };

_$RoutePointImpl _$$RoutePointImplFromJson(Map<String, dynamic> json) =>
    _$RoutePointImpl(
      poiId: json['poiId'] as String,
      order: (json['order'] as num).toInt(),
      durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 0,
      note: json['note'] as String? ?? "",
      additionalData:
          json['additionalData'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$RoutePointImplToJson(_$RoutePointImpl instance) =>
    <String, dynamic>{
      'poiId': instance.poiId,
      'order': instance.order,
      'durationMinutes': instance.durationMinutes,
      'note': instance.note,
      'additionalData': instance.additionalData,
    };
