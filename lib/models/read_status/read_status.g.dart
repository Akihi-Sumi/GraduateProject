// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReadStatusImpl _$$ReadStatusImplFromJson(Map<String, dynamic> json) =>
    _$ReadStatusImpl(
      readStatusId: json['readStatusId'] as String? ?? '',
      lastReadAt: json['lastReadAt'] == null
          ? null
          : DateTime.parse(json['lastReadAt'] as String),
    );

Map<String, dynamic> _$$ReadStatusImplToJson(_$ReadStatusImpl instance) =>
    <String, dynamic>{
      'readStatusId': instance.readStatusId,
      'lastReadAt': instance.lastReadAt?.toIso8601String(),
    };
