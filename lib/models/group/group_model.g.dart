// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupModelImpl _$$GroupModelImplFromJson(Map<String, dynamic> json) =>
    _$GroupModelImpl(
      groupId: json['groupId'] as String? ?? '',
      groupName: json['groupName'] as String? ?? '',
      createUserId: json['createUserId'] as String? ?? '',
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      mods:
          (json['mods'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
      createdAt: _$JsonConverterFromJson<Object, UnionTimestamp>(
          json['createdAt'], unionTimestampConverter.fromJson),
      updatedAt: _$JsonConverterFromJson<Object, UnionTimestamp>(
          json['updatedAt'],
          alwaysUseServerTimestampUnionTimestampConverter.fromJson),
    );

Map<String, dynamic> _$$GroupModelImplToJson(_$GroupModelImpl instance) =>
    <String, dynamic>{
      'groupId': instance.groupId,
      'groupName': instance.groupName,
      'createUserId': instance.createUserId,
      'members': instance.members,
      'mods': instance.mods,
      'createdAt': _$JsonConverterToJson<Object, UnionTimestamp>(
          instance.createdAt, unionTimestampConverter.toJson),
      'updatedAt': _$JsonConverterToJson<Object, UnionTimestamp>(
          instance.updatedAt,
          alwaysUseServerTimestampUnionTimestampConverter.toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
