// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupModelImpl _$$GroupModelImplFromJson(Map<String, dynamic> json) =>
    _$GroupModelImpl(
      groupId: json['groupId'] as String? ?? '',
      groupName: json['groupName'] as String? ?? '',
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      mods:
          (json['mods'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
      createdAt: unionTimestampConverter.fromJson(json['createdAt'] as Object),
    );

Map<String, dynamic> _$$GroupModelImplToJson(_$GroupModelImpl instance) =>
    <String, dynamic>{
      'groupId': instance.groupId,
      'groupName': instance.groupName,
      'members': instance.members,
      'mods': instance.mods,
      'createdAt': unionTimestampConverter.toJson(instance.createdAt),
    };
