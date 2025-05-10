// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventImpl _$$EventImplFromJson(Map<String, dynamic> json) => _$EventImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      location: json['location'] as Map<String, dynamic>,
      category: json['category'] as String,
      startTime: _timestampFromJsonNonNull(json['startTime']),
      endTime: _timestampFromJsonNonNull(json['endTime']),
      organizer: json['organizer'] as String?,
      priceInfo: json['priceInfo'] as String?,
      photos: (json['photos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      additionalData:
          json['additionalData'] as Map<String, dynamic>? ?? const {},
      createdAt: _timestampFromJson(json['createdAt']),
      updatedAt: _timestampFromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$EventImplToJson(_$EventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'category': instance.category,
      'startTime': _timestampToJson(instance.startTime),
      'endTime': _timestampToJson(instance.endTime),
      'organizer': instance.organizer,
      'priceInfo': instance.priceInfo,
      'photos': instance.photos,
      'additionalData': instance.additionalData,
      'createdAt': _timestampToJson(instance.createdAt),
      'updatedAt': _timestampToJson(instance.updatedAt),
    };
