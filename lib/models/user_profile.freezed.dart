// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) {
  return _UserPreferences.fromJson(json);
}

/// @nodoc
mixin _$UserPreferences {
  List<String> get favoriteCategories => throw _privateConstructorUsedError;
  Map<String, bool> get notificationSettings =>
      throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  String get distanceUnit => throw _privateConstructorUsedError; // km or miles
  Map<String, dynamic> get mapSettings => throw _privateConstructorUsedError;

  /// Serializes this UserPreferences to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserPreferencesCopyWith<UserPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPreferencesCopyWith<$Res> {
  factory $UserPreferencesCopyWith(
          UserPreferences value, $Res Function(UserPreferences) then) =
      _$UserPreferencesCopyWithImpl<$Res, UserPreferences>;
  @useResult
  $Res call(
      {List<String> favoriteCategories,
      Map<String, bool> notificationSettings,
      String language,
      String distanceUnit,
      Map<String, dynamic> mapSettings});
}

/// @nodoc
class _$UserPreferencesCopyWithImpl<$Res, $Val extends UserPreferences>
    implements $UserPreferencesCopyWith<$Res> {
  _$UserPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favoriteCategories = null,
    Object? notificationSettings = null,
    Object? language = null,
    Object? distanceUnit = null,
    Object? mapSettings = null,
  }) {
    return _then(_value.copyWith(
      favoriteCategories: null == favoriteCategories
          ? _value.favoriteCategories
          : favoriteCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notificationSettings: null == notificationSettings
          ? _value.notificationSettings
          : notificationSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      distanceUnit: null == distanceUnit
          ? _value.distanceUnit
          : distanceUnit // ignore: cast_nullable_to_non_nullable
              as String,
      mapSettings: null == mapSettings
          ? _value.mapSettings
          : mapSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserPreferencesImplCopyWith<$Res>
    implements $UserPreferencesCopyWith<$Res> {
  factory _$$UserPreferencesImplCopyWith(_$UserPreferencesImpl value,
          $Res Function(_$UserPreferencesImpl) then) =
      __$$UserPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> favoriteCategories,
      Map<String, bool> notificationSettings,
      String language,
      String distanceUnit,
      Map<String, dynamic> mapSettings});
}

/// @nodoc
class __$$UserPreferencesImplCopyWithImpl<$Res>
    extends _$UserPreferencesCopyWithImpl<$Res, _$UserPreferencesImpl>
    implements _$$UserPreferencesImplCopyWith<$Res> {
  __$$UserPreferencesImplCopyWithImpl(
      _$UserPreferencesImpl _value, $Res Function(_$UserPreferencesImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favoriteCategories = null,
    Object? notificationSettings = null,
    Object? language = null,
    Object? distanceUnit = null,
    Object? mapSettings = null,
  }) {
    return _then(_$UserPreferencesImpl(
      favoriteCategories: null == favoriteCategories
          ? _value._favoriteCategories
          : favoriteCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notificationSettings: null == notificationSettings
          ? _value._notificationSettings
          : notificationSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      distanceUnit: null == distanceUnit
          ? _value.distanceUnit
          : distanceUnit // ignore: cast_nullable_to_non_nullable
              as String,
      mapSettings: null == mapSettings
          ? _value._mapSettings
          : mapSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserPreferencesImpl
    with DiagnosticableTreeMixin
    implements _UserPreferences {
  const _$UserPreferencesImpl(
      {final List<String> favoriteCategories = const [],
      final Map<String, bool> notificationSettings = const {},
      this.language = 'en',
      this.distanceUnit = 'km',
      final Map<String, dynamic> mapSettings = const {}})
      : _favoriteCategories = favoriteCategories,
        _notificationSettings = notificationSettings,
        _mapSettings = mapSettings;

  factory _$UserPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserPreferencesImplFromJson(json);

  final List<String> _favoriteCategories;
  @override
  @JsonKey()
  List<String> get favoriteCategories {
    if (_favoriteCategories is EqualUnmodifiableListView)
      return _favoriteCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoriteCategories);
  }

  final Map<String, bool> _notificationSettings;
  @override
  @JsonKey()
  Map<String, bool> get notificationSettings {
    if (_notificationSettings is EqualUnmodifiableMapView)
      return _notificationSettings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_notificationSettings);
  }

  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey()
  final String distanceUnit;
// km or miles
  final Map<String, dynamic> _mapSettings;
// km or miles
  @override
  @JsonKey()
  Map<String, dynamic> get mapSettings {
    if (_mapSettings is EqualUnmodifiableMapView) return _mapSettings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_mapSettings);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserPreferences(favoriteCategories: $favoriteCategories, notificationSettings: $notificationSettings, language: $language, distanceUnit: $distanceUnit, mapSettings: $mapSettings)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserPreferences'))
      ..add(DiagnosticsProperty('favoriteCategories', favoriteCategories))
      ..add(DiagnosticsProperty('notificationSettings', notificationSettings))
      ..add(DiagnosticsProperty('language', language))
      ..add(DiagnosticsProperty('distanceUnit', distanceUnit))
      ..add(DiagnosticsProperty('mapSettings', mapSettings));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPreferencesImpl &&
            const DeepCollectionEquality()
                .equals(other._favoriteCategories, _favoriteCategories) &&
            const DeepCollectionEquality()
                .equals(other._notificationSettings, _notificationSettings) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.distanceUnit, distanceUnit) ||
                other.distanceUnit == distanceUnit) &&
            const DeepCollectionEquality()
                .equals(other._mapSettings, _mapSettings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_favoriteCategories),
      const DeepCollectionEquality().hash(_notificationSettings),
      language,
      distanceUnit,
      const DeepCollectionEquality().hash(_mapSettings));

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      __$$UserPreferencesImplCopyWithImpl<_$UserPreferencesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserPreferencesImplToJson(
      this,
    );
  }
}

abstract class _UserPreferences implements UserPreferences {
  const factory _UserPreferences(
      {final List<String> favoriteCategories,
      final Map<String, bool> notificationSettings,
      final String language,
      final String distanceUnit,
      final Map<String, dynamic> mapSettings}) = _$UserPreferencesImpl;

  factory _UserPreferences.fromJson(Map<String, dynamic> json) =
      _$UserPreferencesImpl.fromJson;

  @override
  List<String> get favoriteCategories;
  @override
  Map<String, bool> get notificationSettings;
  @override
  String get language;
  @override
  String get distanceUnit; // km or miles
  @override
  Map<String, dynamic> get mapSettings;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  List<String> get favoritePlaces => throw _privateConstructorUsedError;
  List<String> get favoriteRoutes => throw _privateConstructorUsedError;
  List<String> get favoriteEvents => throw _privateConstructorUsedError;
  List<String> get following => throw _privateConstructorUsedError;
  List<String> get followers => throw _privateConstructorUsedError;
  UserPreferences get preferences => throw _privateConstructorUsedError;
  int? get routesCount => throw _privateConstructorUsedError;
  int? get reviewsCount => throw _privateConstructorUsedError;
  DateTime? get lastActive => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
          UserProfile value, $Res Function(UserProfile) then) =
      _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call(
      {String id,
      String email,
      String? name,
      String? profileImage,
      String? bio,
      String? location,
      List<String> favoritePlaces,
      List<String> favoriteRoutes,
      List<String> favoriteEvents,
      List<String> following,
      List<String> followers,
      UserPreferences preferences,
      int? routesCount,
      int? reviewsCount,
      DateTime? lastActive,
      DateTime? createdAt,
      DateTime? updatedAt});

  $UserPreferencesCopyWith<$Res> get preferences;
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = freezed,
    Object? profileImage = freezed,
    Object? bio = freezed,
    Object? location = freezed,
    Object? favoritePlaces = null,
    Object? favoriteRoutes = null,
    Object? favoriteEvents = null,
    Object? following = null,
    Object? followers = null,
    Object? preferences = null,
    Object? routesCount = freezed,
    Object? reviewsCount = freezed,
    Object? lastActive = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      favoritePlaces: null == favoritePlaces
          ? _value.favoritePlaces
          : favoritePlaces // ignore: cast_nullable_to_non_nullable
              as List<String>,
      favoriteRoutes: null == favoriteRoutes
          ? _value.favoriteRoutes
          : favoriteRoutes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      favoriteEvents: null == favoriteEvents
          ? _value.favoriteEvents
          : favoriteEvents // ignore: cast_nullable_to_non_nullable
              as List<String>,
      following: null == following
          ? _value.following
          : following // ignore: cast_nullable_to_non_nullable
              as List<String>,
      followers: null == followers
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as UserPreferences,
      routesCount: freezed == routesCount
          ? _value.routesCount
          : routesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      reviewsCount: freezed == reviewsCount
          ? _value.reviewsCount
          : reviewsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      lastActive: freezed == lastActive
          ? _value.lastActive
          : lastActive // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserPreferencesCopyWith<$Res> get preferences {
    return $UserPreferencesCopyWith<$Res>(_value.preferences, (value) {
      return _then(_value.copyWith(preferences: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
          _$UserProfileImpl value, $Res Function(_$UserProfileImpl) then) =
      __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      String? name,
      String? profileImage,
      String? bio,
      String? location,
      List<String> favoritePlaces,
      List<String> favoriteRoutes,
      List<String> favoriteEvents,
      List<String> following,
      List<String> followers,
      UserPreferences preferences,
      int? routesCount,
      int? reviewsCount,
      DateTime? lastActive,
      DateTime? createdAt,
      DateTime? updatedAt});

  @override
  $UserPreferencesCopyWith<$Res> get preferences;
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
      _$UserProfileImpl _value, $Res Function(_$UserProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = freezed,
    Object? profileImage = freezed,
    Object? bio = freezed,
    Object? location = freezed,
    Object? favoritePlaces = null,
    Object? favoriteRoutes = null,
    Object? favoriteEvents = null,
    Object? following = null,
    Object? followers = null,
    Object? preferences = null,
    Object? routesCount = freezed,
    Object? reviewsCount = freezed,
    Object? lastActive = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$UserProfileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      favoritePlaces: null == favoritePlaces
          ? _value._favoritePlaces
          : favoritePlaces // ignore: cast_nullable_to_non_nullable
              as List<String>,
      favoriteRoutes: null == favoriteRoutes
          ? _value._favoriteRoutes
          : favoriteRoutes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      favoriteEvents: null == favoriteEvents
          ? _value._favoriteEvents
          : favoriteEvents // ignore: cast_nullable_to_non_nullable
              as List<String>,
      following: null == following
          ? _value._following
          : following // ignore: cast_nullable_to_non_nullable
              as List<String>,
      followers: null == followers
          ? _value._followers
          : followers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as UserPreferences,
      routesCount: freezed == routesCount
          ? _value.routesCount
          : routesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      reviewsCount: freezed == reviewsCount
          ? _value.reviewsCount
          : reviewsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      lastActive: freezed == lastActive
          ? _value.lastActive
          : lastActive // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl with DiagnosticableTreeMixin implements _UserProfile {
  const _$UserProfileImpl(
      {required this.id,
      required this.email,
      this.name,
      this.profileImage,
      this.bio,
      this.location,
      final List<String> favoritePlaces = const [],
      final List<String> favoriteRoutes = const [],
      final List<String> favoriteEvents = const [],
      final List<String> following = const [],
      final List<String> followers = const [],
      this.preferences = const UserPreferences(),
      this.routesCount,
      this.reviewsCount,
      this.lastActive,
      this.createdAt,
      this.updatedAt})
      : _favoritePlaces = favoritePlaces,
        _favoriteRoutes = favoriteRoutes,
        _favoriteEvents = favoriteEvents,
        _following = following,
        _followers = followers;

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String? name;
  @override
  final String? profileImage;
  @override
  final String? bio;
  @override
  final String? location;
  final List<String> _favoritePlaces;
  @override
  @JsonKey()
  List<String> get favoritePlaces {
    if (_favoritePlaces is EqualUnmodifiableListView) return _favoritePlaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoritePlaces);
  }

  final List<String> _favoriteRoutes;
  @override
  @JsonKey()
  List<String> get favoriteRoutes {
    if (_favoriteRoutes is EqualUnmodifiableListView) return _favoriteRoutes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoriteRoutes);
  }

  final List<String> _favoriteEvents;
  @override
  @JsonKey()
  List<String> get favoriteEvents {
    if (_favoriteEvents is EqualUnmodifiableListView) return _favoriteEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoriteEvents);
  }

  final List<String> _following;
  @override
  @JsonKey()
  List<String> get following {
    if (_following is EqualUnmodifiableListView) return _following;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_following);
  }

  final List<String> _followers;
  @override
  @JsonKey()
  List<String> get followers {
    if (_followers is EqualUnmodifiableListView) return _followers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_followers);
  }

  @override
  @JsonKey()
  final UserPreferences preferences;
  @override
  final int? routesCount;
  @override
  final int? reviewsCount;
  @override
  final DateTime? lastActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserProfile(id: $id, email: $email, name: $name, profileImage: $profileImage, bio: $bio, location: $location, favoritePlaces: $favoritePlaces, favoriteRoutes: $favoriteRoutes, favoriteEvents: $favoriteEvents, following: $following, followers: $followers, preferences: $preferences, routesCount: $routesCount, reviewsCount: $reviewsCount, lastActive: $lastActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserProfile'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('profileImage', profileImage))
      ..add(DiagnosticsProperty('bio', bio))
      ..add(DiagnosticsProperty('location', location))
      ..add(DiagnosticsProperty('favoritePlaces', favoritePlaces))
      ..add(DiagnosticsProperty('favoriteRoutes', favoriteRoutes))
      ..add(DiagnosticsProperty('favoriteEvents', favoriteEvents))
      ..add(DiagnosticsProperty('following', following))
      ..add(DiagnosticsProperty('followers', followers))
      ..add(DiagnosticsProperty('preferences', preferences))
      ..add(DiagnosticsProperty('routesCount', routesCount))
      ..add(DiagnosticsProperty('reviewsCount', reviewsCount))
      ..add(DiagnosticsProperty('lastActive', lastActive))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality()
                .equals(other._favoritePlaces, _favoritePlaces) &&
            const DeepCollectionEquality()
                .equals(other._favoriteRoutes, _favoriteRoutes) &&
            const DeepCollectionEquality()
                .equals(other._favoriteEvents, _favoriteEvents) &&
            const DeepCollectionEquality()
                .equals(other._following, _following) &&
            const DeepCollectionEquality()
                .equals(other._followers, _followers) &&
            (identical(other.preferences, preferences) ||
                other.preferences == preferences) &&
            (identical(other.routesCount, routesCount) ||
                other.routesCount == routesCount) &&
            (identical(other.reviewsCount, reviewsCount) ||
                other.reviewsCount == reviewsCount) &&
            (identical(other.lastActive, lastActive) ||
                other.lastActive == lastActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      name,
      profileImage,
      bio,
      location,
      const DeepCollectionEquality().hash(_favoritePlaces),
      const DeepCollectionEquality().hash(_favoriteRoutes),
      const DeepCollectionEquality().hash(_favoriteEvents),
      const DeepCollectionEquality().hash(_following),
      const DeepCollectionEquality().hash(_followers),
      preferences,
      routesCount,
      reviewsCount,
      lastActive,
      createdAt,
      updatedAt);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(
      this,
    );
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile(
      {required final String id,
      required final String email,
      final String? name,
      final String? profileImage,
      final String? bio,
      final String? location,
      final List<String> favoritePlaces,
      final List<String> favoriteRoutes,
      final List<String> favoriteEvents,
      final List<String> following,
      final List<String> followers,
      final UserPreferences preferences,
      final int? routesCount,
      final int? reviewsCount,
      final DateTime? lastActive,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String? get name;
  @override
  String? get profileImage;
  @override
  String? get bio;
  @override
  String? get location;
  @override
  List<String> get favoritePlaces;
  @override
  List<String> get favoriteRoutes;
  @override
  List<String> get favoriteEvents;
  @override
  List<String> get following;
  @override
  List<String> get followers;
  @override
  UserPreferences get preferences;
  @override
  int? get routesCount;
  @override
  int? get reviewsCount;
  @override
  DateTime? get lastActive;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
