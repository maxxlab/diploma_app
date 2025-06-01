// lib/models/report.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'report.freezed.dart';
part 'report.g.dart';

enum ReportType {
  @JsonValue('place_related')
  placeRelated,
  @JsonValue('city_council')
  cityCouncil,
  @JsonValue('other')
  other,
}

enum ReportStatus {
  @JsonValue('created')
  created,
  @JsonValue('reviewed')
  reviewed,
  @JsonValue('solved')
  solved,
}

@freezed
class Report with _$Report {
  const factory Report({
    required String id,
    required String poiId,
    required String poiName,
    required String userId,
    required ReportType reportType,
    required String description,
    @Default(ReportStatus.created) ReportStatus status,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) DateTime? createdAt,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) DateTime? updatedAt,
    @Default({}) Map<String, dynamic> additionalData,
  }) = _Report;

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  factory Report.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return Report.fromJson({
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

extension ReportTypeExtension on ReportType {
  String get displayName {
    switch (this) {
      case ReportType.placeRelated:
        return 'Issue with the place';
      case ReportType.cityCouncil:
        return 'City council matter';
      case ReportType.other:
        return 'Other issue';
    }
  }
}

extension ReportStatusExtension on ReportStatus {
  String get displayName {
    switch (this) {
      case ReportStatus.created:
        return 'Created';
      case ReportStatus.reviewed:
        return 'Under Review';
      case ReportStatus.solved:
        return 'Resolved';
    }
  }
}