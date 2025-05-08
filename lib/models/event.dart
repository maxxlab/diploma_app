// lib/models/event.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

enum EventCategory {
  cultural,
  sport,
  entertainment,
  educational,
  religious,
  other
}

extension EventCategoryExtension on EventCategory {
  String get displayName {
    switch (this) {
      case EventCategory.cultural:
        return 'Cultural';
      case EventCategory.sport:
        return 'Sport';
      case EventCategory.entertainment:
        return 'Entertainment';
      case EventCategory.educational:
        return 'Educational';
      case EventCategory.religious:
        return 'Religious';
      case EventCategory.other:
        return 'Other';
    }
  }

  String get iconName {
    switch (this) {
      case EventCategory.cultural:
        return 'cultural';
      case EventCategory.sport:
        return 'sport';
      case EventCategory.entertainment:
        return 'entertainment';
      case EventCategory.educational:
        return 'educational';
      case EventCategory.religious:
        return 'religious';
      case EventCategory.other:
        return 'other';
    }
  }
}

@freezed
class Event with _$Event {
  const factory Event({
    required String id,
    required String name,
    required String description,
    required String placeId,
    String? placeAddress,
    required double latitude,
    required double longitude,
    required EventCategory category,
    required DateTime startDate,
    DateTime? endDate,
    String? organizer,
    String? contactPhone,
    String? contactEmail,
    String? website,
    List<String>? images,
    String? thumbnail,
    double? price,
    String? currency,
    String? ticketUrl,
    @Default(false) bool isFree,
    @Default([]) List<String> tags,
    @Default(false) bool isFavorite,
    int? interestedCount,
    int? goingCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  factory Event.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return Event.fromJson({
      'id': doc.id,
      ...data,
      'startDate': data['startDate'] != null
          ? (data['startDate'] as Timestamp).toDate()
          : DateTime.now(),
      'endDate': data['endDate'] != null
          ? (data['endDate'] as Timestamp).toDate()
          : null,
      'createdAt': data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      'updatedAt': data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
    });
  }
}

extension EventX on Event {
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    // Remove id as it's stored as document ID
    json.remove('id');

    // Update timestamps
    json['updatedAt'] = FieldValue.serverTimestamp();
    if (createdAt == null) {
      json['createdAt'] = FieldValue.serverTimestamp();
    }

    return json;
  }

  bool get isActive {
    final now = DateTime.now();
    if (endDate != null) {
      return now.isBefore(endDate!);
    }
    return now.isBefore(startDate.add(const Duration(days: 1)));
  }
}