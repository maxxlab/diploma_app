// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_poi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FavoritePOIImpl _$$FavoritePOIImplFromJson(Map<String, dynamic> json) =>
    _$FavoritePOIImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      poiId: json['poiId'] as String,
      poiName: json['poiName'] as String,
      poiDescription: json['poiDescription'] as String,
      poiCategory: json['poiCategory'] as String,
      poiLatitude: (json['poiLatitude'] as num).toDouble(),
      poiLongitude: (json['poiLongitude'] as num).toDouble(),
      poiAddress: json['poiAddress'] as String?,
      poiRating: (json['poiRating'] as num?)?.toDouble() ?? 0.0,
      createdAt: _timestampFromJson(json['createdAt']),
    );

Map<String, dynamic> _$$FavoritePOIImplToJson(_$FavoritePOIImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'poiId': instance.poiId,
      'poiName': instance.poiName,
      'poiDescription': instance.poiDescription,
      'poiCategory': instance.poiCategory,
      'poiLatitude': instance.poiLatitude,
      'poiLongitude': instance.poiLongitude,
      'poiAddress': instance.poiAddress,
      'poiRating': instance.poiRating,
      'createdAt': _timestampToJson(instance.createdAt),
    };
