// // lib/models/route.dart
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// part 'route.freezed.dart';
// part 'route.g.dart';
//
// @freezed
// class TouristRoute with _$TouristRoute {
//   const factory TouristRoute({
//     required String id,
//     required String name,
//     required String description,
//     required String creatorId,
//     @Default([]) List<RoutePoint> points,
//     @Default(0) int estimatedTimeMinutes,
//     @Default(0.0) double distanceKm,
//     @Default(true) bool isPublic,
//     @Default([]) List<String> tags,
//     @Default({}) Map<String, dynamic> additionalData,
//     @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) DateTime? createdAt,
//     @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) DateTime? updatedAt,
//   }) = _TouristRoute;
//
//   factory TouristRoute.fromJson(Map<String, dynamic> json) => _$TouristRouteFromJson(json);
//
//   factory TouristRoute.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>? ?? {};
//     return TouristRoute.fromJson({
//       'id': doc.id,
//       ...data,
//     });
//   }
// }
//
// @freezed
// class RoutePoint with _$RoutePoint {
//   const factory RoutePoint({
//     required String poiId,
//     required int order,
//     @Default(0) int durationMinutes,
//     @Default("") String note,
//     @Default({}) Map<String, dynamic> additionalData,
//   }) = _RoutePoint;
//
//   factory RoutePoint.fromJson(Map<String, dynamic> json) => _$RoutePointFromJson(json);
// }
//
// DateTime? _timestampFromJson(dynamic value) {
//   if (value == null) return null;
//   if (value is Timestamp) {
//     return value.toDate();
//   }
//   return null;
// }
//
// dynamic _timestampToJson(DateTime? dateTime) {
//   if (dateTime == null) return null;
//   return Timestamp.fromDate(dateTime);
// }