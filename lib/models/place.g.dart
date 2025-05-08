// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlaceImpl _$$PlaceImplFromJson(Map<String, dynamic> json) => _$PlaceImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      category: $enumDecode(_$PlaceCategoryEnumMap, json['category']),
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      thumbnail: json['thumbnail'] as String?,
      openingHours: json['openingHours'] as Map<String, dynamic>?,
      rating: (json['rating'] as num?)?.toDouble(),
      ratingCount: (json['ratingCount'] as num?)?.toInt(),
      additionalInfo: json['additionalInfo'] as Map<String, dynamic>?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$PlaceImplToJson(_$PlaceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'category': _$PlaceCategoryEnumMap[instance.category]!,
      'address': instance.address,
      'phone': instance.phone,
      'website': instance.website,
      'images': instance.images,
      'thumbnail': instance.thumbnail,
      'openingHours': instance.openingHours,
      'rating': instance.rating,
      'ratingCount': instance.ratingCount,
      'additionalInfo': instance.additionalInfo,
      'isFavorite': instance.isFavorite,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$PlaceCategoryEnumMap = {
  PlaceCategory.attraction: 'attraction',
  PlaceCategory.restaurant: 'restaurant',
  PlaceCategory.hotel: 'hotel',
  PlaceCategory.transport: 'transport',
  PlaceCategory.event: 'event',
  PlaceCategory.other: 'other',
};
