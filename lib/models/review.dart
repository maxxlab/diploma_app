// lib/models/review.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

part 'review.freezed.dart';
part 'review.g.dart';

enum ReviewType {
  place,
  route
}

@freezed
class Review with _$Review {
  const factory Review({
    required String id,
    required String userId,
    required String userName,
    String? userProfileImage,
    required String targetId, // placeId or routeId
    required ReviewType targetType,
    required double rating, // 1-5 rating
    required String comment,
    List<String>? images,
    @Default([]) List<String> likes,
    int? helpfulCount,
    DateTime? visitDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  factory Review.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return Review.fromJson({
      'id': doc.id,
      ...data,
      'createdAt': data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      'updatedAt': data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
      'visitDate': data['visitDate'] != null
          ? (data['visitDate'] as Timestamp).toDate()
          : null,
    });
  }
}

extension ReviewX on Review {
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