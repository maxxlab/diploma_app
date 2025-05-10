// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CachedRegionImpl _$$CachedRegionImplFromJson(Map<String, dynamic> json) =>
    _$CachedRegionImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      centerCoordinates: json['centerCoordinates'] as Map<String, dynamic>,
      radius: (json['radius'] as num).toDouble(),
      cachedCategories: (json['cachedCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      detailLevel: (json['detailLevel'] as num?)?.toInt() ?? 1,
      sizeBytes: (json['sizeBytes'] as num?)?.toInt() ?? 0,
      lastSynced: _timestampFromJson(json['lastSynced']),
      createdAt: _timestampFromJson(json['createdAt']),
    );

Map<String, dynamic> _$$CachedRegionImplToJson(_$CachedRegionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'centerCoordinates': instance.centerCoordinates,
      'radius': instance.radius,
      'cachedCategories': instance.cachedCategories,
      'detailLevel': instance.detailLevel,
      'sizeBytes': instance.sizeBytes,
      'lastSynced': _timestampToJson(instance.lastSynced),
      'createdAt': _timestampToJson(instance.createdAt),
    };
