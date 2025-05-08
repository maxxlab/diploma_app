// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userProfileImage: json['userProfileImage'] as String?,
      targetId: json['targetId'] as String,
      targetType: $enumDecode(_$ReviewTypeEnumMap, json['targetType']),
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      likes:
          (json['likes'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      helpfulCount: (json['helpfulCount'] as num?)?.toInt(),
      visitDate: json['visitDate'] == null
          ? null
          : DateTime.parse(json['visitDate'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'userProfileImage': instance.userProfileImage,
      'targetId': instance.targetId,
      'targetType': _$ReviewTypeEnumMap[instance.targetType]!,
      'rating': instance.rating,
      'comment': instance.comment,
      'images': instance.images,
      'likes': instance.likes,
      'helpfulCount': instance.helpfulCount,
      'visitDate': instance.visitDate?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$ReviewTypeEnumMap = {
  ReviewType.place: 'place',
  ReviewType.route: 'route',
};
