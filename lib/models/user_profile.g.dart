// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserPreferencesImpl _$$UserPreferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$UserPreferencesImpl(
      favoriteCategories: (json['favoriteCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      notificationSettings:
          (json['notificationSettings'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as bool),
              ) ??
              const {},
      language: json['language'] as String? ?? 'en',
      distanceUnit: json['distanceUnit'] as String? ?? 'km',
      mapSettings: json['mapSettings'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$UserPreferencesImplToJson(
        _$UserPreferencesImpl instance) =>
    <String, dynamic>{
      'favoriteCategories': instance.favoriteCategories,
      'notificationSettings': instance.notificationSettings,
      'language': instance.language,
      'distanceUnit': instance.distanceUnit,
      'mapSettings': instance.mapSettings,
    };

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      profileImage: json['profileImage'] as String?,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      favoritePlaces: (json['favoritePlaces'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      favoriteRoutes: (json['favoriteRoutes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      favoriteEvents: (json['favoriteEvents'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      following: (json['following'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      followers: (json['followers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      preferences: json['preferences'] == null
          ? const UserPreferences()
          : UserPreferences.fromJson(
              json['preferences'] as Map<String, dynamic>),
      routesCount: (json['routesCount'] as num?)?.toInt(),
      reviewsCount: (json['reviewsCount'] as num?)?.toInt(),
      lastActive: json['lastActive'] == null
          ? null
          : DateTime.parse(json['lastActive'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'profileImage': instance.profileImage,
      'bio': instance.bio,
      'location': instance.location,
      'favoritePlaces': instance.favoritePlaces,
      'favoriteRoutes': instance.favoriteRoutes,
      'favoriteEvents': instance.favoriteEvents,
      'following': instance.following,
      'followers': instance.followers,
      'preferences': instance.preferences,
      'routesCount': instance.routesCount,
      'reviewsCount': instance.reviewsCount,
      'lastActive': instance.lastActive?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
