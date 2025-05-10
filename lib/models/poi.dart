// lib/models/poi.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'poi.freezed.dart';
part 'poi.g.dart';

@freezed
class POI with _$POI {
  const factory POI({
    required String id,
    required String name,
    required String description,
    required String category,
    @JsonKey(fromJson: _geoPointFromJson, toJson: _geoPointToJson) required GeoPoint location, // Use Firebase GeoPoint
    String? address,
    Map<String, String>? contactInfo,
    Map<String, dynamic>? workingHours,
    List<String>? photos,
    @Default(0.0) double averageRating,
    String? priceCategory,
    @Default(false) bool isAccessible,
    String? region,
    @Default({}) Map<String, dynamic> additionalData,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) DateTime? createdAt,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) DateTime? updatedAt,
  }) = _POI;

  factory POI.fromJson(Map<String, dynamic> json) => _$POIFromJson(json);

  factory POI.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return POI.fromJson({
      'id': doc.id,
      ...data,
    });
  }
}

// Converters for Firebase GeoPoint
GeoPoint _geoPointFromJson(dynamic json) {
  if (json is GeoPoint) return json;
  if (json is Map<String, dynamic>) {
    return GeoPoint(
        json['latitude'] as double,
        json['longitude'] as double
    );
  }
  return GeoPoint(0, 0); // Default to 0,0 if invalid
}

Map<String, dynamic> _geoPointToJson(GeoPoint geoPoint) {
  return {
    'latitude': geoPoint.latitude,
    'longitude': geoPoint.longitude,
  };
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