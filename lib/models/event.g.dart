// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventImpl _$$EventImplFromJson(Map<String, dynamic> json) => _$EventImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      placeId: json['placeId'] as String,
      placeAddress: json['placeAddress'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      category: $enumDecode(_$EventCategoryEnumMap, json['category']),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      organizer: json['organizer'] as String?,
      contactPhone: json['contactPhone'] as String?,
      contactEmail: json['contactEmail'] as String?,
      website: json['website'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      thumbnail: json['thumbnail'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      ticketUrl: json['ticketUrl'] as String?,
      isFree: json['isFree'] as bool? ?? false,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      isFavorite: json['isFavorite'] as bool? ?? false,
      interestedCount: (json['interestedCount'] as num?)?.toInt(),
      goingCount: (json['goingCount'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$EventImplToJson(_$EventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'placeId': instance.placeId,
      'placeAddress': instance.placeAddress,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'category': _$EventCategoryEnumMap[instance.category]!,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'organizer': instance.organizer,
      'contactPhone': instance.contactPhone,
      'contactEmail': instance.contactEmail,
      'website': instance.website,
      'images': instance.images,
      'thumbnail': instance.thumbnail,
      'price': instance.price,
      'currency': instance.currency,
      'ticketUrl': instance.ticketUrl,
      'isFree': instance.isFree,
      'tags': instance.tags,
      'isFavorite': instance.isFavorite,
      'interestedCount': instance.interestedCount,
      'goingCount': instance.goingCount,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$EventCategoryEnumMap = {
  EventCategory.cultural: 'cultural',
  EventCategory.sport: 'sport',
  EventCategory.entertainment: 'entertainment',
  EventCategory.educational: 'educational',
  EventCategory.religious: 'religious',
  EventCategory.other: 'other',
};
