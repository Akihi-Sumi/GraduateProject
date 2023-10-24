// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deleted_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeletedUserImpl _$$DeletedUserImplFromJson(Map<String, dynamic> json) =>
    _$DeletedUserImpl(
      uid: json['uid'] as String? ?? '',
      createdAt: alwaysUseServerTimestampUnionTimestampConverter
          .fromJson(json['createdAt'] as Object),
    );

Map<String, dynamic> _$$DeletedUserImplToJson(_$DeletedUserImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'createdAt': alwaysUseServerTimestampUnionTimestampConverter
          .toJson(instance.createdAt),
    };
