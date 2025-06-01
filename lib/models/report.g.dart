// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportImpl _$$ReportImplFromJson(Map<String, dynamic> json) => _$ReportImpl(
      id: json['id'] as String,
      poiId: json['poiId'] as String,
      poiName: json['poiName'] as String,
      userId: json['userId'] as String,
      reportType: $enumDecode(_$ReportTypeEnumMap, json['reportType']),
      description: json['description'] as String,
      status: $enumDecodeNullable(_$ReportStatusEnumMap, json['status']) ??
          ReportStatus.created,
      createdAt: _timestampFromJson(json['createdAt']),
      updatedAt: _timestampFromJson(json['updatedAt']),
      additionalData:
          json['additionalData'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$ReportImplToJson(_$ReportImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'poiId': instance.poiId,
      'poiName': instance.poiName,
      'userId': instance.userId,
      'reportType': _$ReportTypeEnumMap[instance.reportType]!,
      'description': instance.description,
      'status': _$ReportStatusEnumMap[instance.status]!,
      'createdAt': _timestampToJson(instance.createdAt),
      'updatedAt': _timestampToJson(instance.updatedAt),
      'additionalData': instance.additionalData,
    };

const _$ReportTypeEnumMap = {
  ReportType.placeRelated: 'place_related',
  ReportType.cityCouncil: 'city_council',
  ReportType.other: 'other',
};

const _$ReportStatusEnumMap = {
  ReportStatus.created: 'created',
  ReportStatus.reviewed: 'reviewed',
  ReportStatus.solved: 'solved',
};
