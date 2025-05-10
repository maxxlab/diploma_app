// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
      id: json['id'] as String,
      poiId: json['poiId'] as String,
      userId: json['userId'] as String,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String?,
      photos: (json['photos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isVerified: json['isVerified'] as bool? ?? false,
      createdAt: _timestampFromJson(json['createdAt']),
      updatedAt: _timestampFromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'poiId': instance.poiId,
      'userId': instance.userId,
      'rating': instance.rating,
      'comment': instance.comment,
      'photos': instance.photos,
      'isVerified': instance.isVerified,
      'createdAt': _timestampToJson(instance.createdAt),
      'updatedAt': _timestampToJson(instance.updatedAt),
    };
