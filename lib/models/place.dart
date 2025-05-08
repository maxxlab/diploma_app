// lib/models/place.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

part 'place.freezed.dart';
part 'place.g.dart';

enum PlaceCategory {
  attraction,
  restaurant,
  hotel,
  transport,
  event,
  other
}

extension PlaceCategoryExtension on PlaceCategory {
  String get displayName {
    switch (this) {
      case PlaceCategory.attraction:
        return 'Attraction';
      case PlaceCategory.restaurant:
        return 'Restaurant';
      case PlaceCategory.hotel:
        return 'Hotel';
      case PlaceCategory.transport:
        return 'Transport';
      case PlaceCategory.event:
        return 'Event';
      case PlaceCategory.other:
        return 'Other';
    }
  }

  String get iconName {
    switch (this) {
      case PlaceCategory.attraction:
        return 'attraction';
      case PlaceCategory.restaurant:
        return 'restaurant';
      case PlaceCategory.hotel:
        return 'hotel';
      case PlaceCategory.transport:
        return 'transport';
      case PlaceCategory.event:
        return 'event';
      case PlaceCategory.other:
        return 'other';
    }
  }
}

@freezed
class Place with _$Place {
  const factory Place({
    required String id,
    required String name,
    required String description,
    required double latitude,
    required double longitude,
    required PlaceCategory category,
    String? address,
    String? phone,
    String? website,
    List<String>? images,
    String? thumbnail,
    Map<String, dynamic>? openingHours,
    double? rating,
    int? ratingCount,
    Map<String, dynamic>? additionalInfo,
    @Default(false) bool isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  factory Place.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return Place.fromJson({
      'id': doc.id,
      ...data,
      'createdAt': data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      'updatedAt': data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
    });
  }
}

extension PlaceX on Place {
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
}