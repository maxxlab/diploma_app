// lib/models/cached_region.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'cached_region.freezed.dart';
part 'cached_region.g.dart';

@freezed
class CachedRegion with _$CachedRegion {
  const factory CachedRegion({
    required String id,
    required String name,
    required Map<String, dynamic> centerCoordinates,
    required double radius,
    @Default([]) List<String> cachedCategories,
    @Default(1) int detailLevel,
    @Default(0) int sizeBytes,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) DateTime? lastSynced,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) DateTime? createdAt,
  }) = _CachedRegion;

  factory CachedRegion.fromJson(Map<String, dynamic> json) => _$CachedRegionFromJson(json);

  factory CachedRegion.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return CachedRegion.fromJson({
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