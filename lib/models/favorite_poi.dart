// lib/models/favorite_poi.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'favorite_poi.freezed.dart';
part 'favorite_poi.g.dart';

@freezed
class FavoritePOI with _$FavoritePOI {
  const factory FavoritePOI({
    required String id,
    required String userId,
    required String poiId,
    required String poiName,
    required String poiDescription,
    required String poiCategory,
    required double poiLatitude,
    required double poiLongitude,
    String? poiAddress,
    @Default(0.0) double poiRating,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) DateTime? createdAt,
  }) = _FavoritePOI;

  factory FavoritePOI.fromJson(Map<String, dynamic> json) => _$FavoritePOIFromJson(json);

  factory FavoritePOI.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return FavoritePOI.fromJson({
      'id': doc.id,
      ...data,
    });
  }
}

DateTime? _timestampFromJson(dynamic value) {
  if (value == null) return null;
  if (value is Timestamp) {
    return value.toDate();
  }
  return null;
}

dynamic _timestampToJson(DateTime? dateTime) {
  if (dateTime == null) return null;
  return Timestamp.fromDate(dateTime);
}