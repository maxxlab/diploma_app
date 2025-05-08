// lib/models/route.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

part 'route.freezed.dart';
part 'route.g.dart';

enum RouteTransportType {
  walking,
  cycling,
  publicTransport,
  driving,
  mixed
}

extension RouteTransportTypeExtension on RouteTransportType {
  String get displayName {
    switch (this) {
      case RouteTransportType.walking:
        return 'Walking';
      case RouteTransportType.cycling:
        return 'Cycling';
      case RouteTransportType.publicTransport:
        return 'Public Transport';
      case RouteTransportType.driving:
        return 'Driving';
      case RouteTransportType.mixed:
        return 'Mixed';
    }
  }

  String get iconName {
    switch (this) {
      case RouteTransportType.walking:
        return 'walking';
      case RouteTransportType.cycling:
        return 'cycling';
      case RouteTransportType.publicTransport:
        return 'bus';
      case RouteTransportType.driving:
        return 'car';
      case RouteTransportType.mixed:
        return 'mixed';
    }
  }
}

@freezed
class RoutePoint with _$RoutePoint {
  const factory RoutePoint({
    required String placeId,
    required int order,
    String? note,
    int? durationMinutes,
  }) = _RoutePoint;

  factory RoutePoint.fromJson(Map<String, dynamic> json) => _$RoutePointFromJson(json);
}

@freezed
class Route with _$Route {
  const factory Route({
    required String id,
    required String name,
    required String description,
    required String userId,
    required List<RoutePoint> points,
    required RouteTransportType transportType,
    double? totalDistanceKm,
    int? estimatedDurationMinutes,
    String? thumbnail,
    double? rating,
    int? ratingCount,
    @Default(false) bool isPublic,
    @Default(false) bool isFavorite,
    @Default([]) List<String> tags,
    int? viewCount,
    int? copyCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Route;

  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);

  factory Route.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return Route.fromJson({
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

extension RouteX on Route {
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