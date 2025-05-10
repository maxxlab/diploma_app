// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$POIImpl _$$POIImplFromJson(Map<String, dynamic> json) => _$POIImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      location: _geoPointFromJson(json['location']),
      address: json['address'] as String?,
      contactInfo: (json['contactInfo'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      workingHours: json['workingHours'] as Map<String, dynamic>?,
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      priceCategory: json['priceCategory'] as String?,
      isAccessible: json['isAccessible'] as bool? ?? false,
      region: json['region'] as String?,
      additionalData:
          json['additionalData'] as Map<String, dynamic>? ?? const {},
      createdAt: _timestampFromJson(json['createdAt']),
      updatedAt: _timestampFromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$POIImplToJson(_$POIImpl instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'location': _geoPointToJson(instance.location),
      'address': instance.address,
      'contactInfo': instance.contactInfo,
      'workingHours': instance.workingHours,
      'photos': instance.photos,
      'averageRating': instance.averageRating,
      'priceCategory': instance.priceCategory,
      'isAccessible': instance.isAccessible,
      'region': instance.region,
      'additionalData': instance.additionalData,
      'createdAt': _timestampToJson(instance.createdAt),
      'updatedAt': _timestampToJson(instance.updatedAt),
    };
