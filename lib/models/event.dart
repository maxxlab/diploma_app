// lib/models/event.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@freezed
class Event with _$Event {
  const factory Event({
    required String id,
    required String name,
    required String description,
    required Map<String, dynamic> location,
    required String category,
    @JsonKey(fromJson: _timestampFromJsonNonNull, toJson: _timestampToJson) required DateTime startTime,
    @JsonKey(fromJson: _timestampFromJsonNonNull, toJson: _timestampToJson) required DateTime endTime,
    String? organizer,
    String? priceInfo,
    @Default([]) List<String> photos,
    @Default({}) Map<String, dynamic> additionalData,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) DateTime? createdAt,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) DateTime? updatedAt,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  factory Event.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return Event.fromJson({
      'id': doc.id,
      ...data,
    });
  }
}

// For required DateTime fields - returns current time if null
DateTime _timestampFromJsonNonNull(dynamic value) {
  if (value == null) return DateTime.now();
  if (value is Timestamp) {
    return value.toDate();
  }
  return DateTime.now();
}

// For nullable DateTime fields
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