// lib/models/area.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'area.freezed.dart';
part 'area.g.dart';

@freezed
class Area with _$Area {
  const factory Area({
    required String id,
    required String data,  // GeoJSON string
    required String type,  // Area type (e.g., "walking")
  }) = _Area;

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);

  factory Area.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return Area.fromJson({
      'id': doc.id,
      'data': data['data'] ?? '{}',
      'type': data['type'] ?? 'unknown',
    });
  }
}