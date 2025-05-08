// lib/models/user_profile.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'user.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    @Default([]) List<String> favoriteCategories,
    @Default({}) Map<String, bool> notificationSettings,
    @Default('en') String language,
    @Default('km') String distanceUnit, // km or miles
    @Default({}) Map<String, dynamic> mapSettings,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
}

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String email,
    String? name,
    String? profileImage,
    String? bio,
    String? location,
    @Default([]) List<String> favoritePlaces,
    @Default([]) List<String> favoriteRoutes,
    @Default([]) List<String> favoriteEvents,
    @Default([]) List<String> following,
    @Default([]) List<String> followers,
    @Default(UserPreferences()) UserPreferences preferences,
    int? routesCount,
    int? reviewsCount,
    DateTime? lastActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  factory UserProfile.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return UserProfile.fromJson({
      'id': doc.id,
      ...data,
      'lastActive': data['lastActive'] != null
          ? (data['lastActive'] as Timestamp).toDate()
          : null,
      'createdAt': data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      'updatedAt': data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
    });
  }

  // Create from basic User
  factory UserProfile.fromUser(User user) {
    return UserProfile(
      id: user.id,
      email: user.email,
      name: user.name,
      profileImage: user.profileImage,
      createdAt: DateTime.now(),
    );
  }
}

extension UserProfileX on UserProfile {
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    // Remove id as it's stored as document ID
    json.remove('id');

    // Update timestamps
    json['updatedAt'] = FieldValue.serverTimestamp();
    json['lastActive'] = FieldValue.serverTimestamp();
    if (createdAt == null) {
      json['createdAt'] = FieldValue.serverTimestamp();
    }

    return json;
  }
}