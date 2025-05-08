// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoutePointImpl _$$RoutePointImplFromJson(Map<String, dynamic> json) =>
    _$RoutePointImpl(
      placeId: json['placeId'] as String,
      order: (json['order'] as num).toInt(),
      note: json['note'] as String?,
      durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$RoutePointImplToJson(_$RoutePointImpl instance) =>
    <String, dynamic>{
      'placeId': instance.placeId,
      'order': instance.order,
      'note': instance.note,
      'durationMinutes': instance.durationMinutes,
    };

_$RouteImpl _$$RouteImplFromJson(Map<String, dynamic> json) => _$RouteImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      userId: json['userId'] as String,
      points: (json['points'] as List<dynamic>)
          .map((e) => RoutePoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      transportType:
          $enumDecode(_$RouteTransportTypeEnumMap, json['transportType']),
      totalDistanceKm: (json['totalDistanceKm'] as num?)?.toDouble(),
      estimatedDurationMinutes:
          (json['estimatedDurationMinutes'] as num?)?.toInt(),
      thumbnail: json['thumbnail'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      ratingCount: (json['ratingCount'] as num?)?.toInt(),
      isPublic: json['isPublic'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      viewCount: (json['viewCount'] as num?)?.toInt(),
      copyCount: (json['copyCount'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$RouteImplToJson(_$RouteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'userId': instance.userId,
      'points': instance.points,
      'transportType': _$RouteTransportTypeEnumMap[instance.transportType]!,
      'totalDistanceKm': instance.totalDistanceKm,
      'estimatedDurationMinutes': instance.estimatedDurationMinutes,
      'thumbnail': instance.thumbnail,
      'rating': instance.rating,
      'ratingCount': instance.ratingCount,
      'isPublic': instance.isPublic,
      'isFavorite': instance.isFavorite,
      'tags': instance.tags,
      'viewCount': instance.viewCount,
      'copyCount': instance.copyCount,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$RouteTransportTypeEnumMap = {
  RouteTransportType.walking: 'walking',
  RouteTransportType.cycling: 'cycling',
  RouteTransportType.publicTransport: 'publicTransport',
  RouteTransportType.driving: 'driving',
  RouteTransportType.mixed: 'mixed',
};
