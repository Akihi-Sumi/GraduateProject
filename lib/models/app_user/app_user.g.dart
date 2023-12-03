// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      userId: json['userId'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      userEmail: json['userEmail'] as String? ?? '',
      userEvacuation: json['userEvacuation'] as String? ?? '',
      profilePicture: json['profilePicture'] as String? ?? '',
      createdAt: _$JsonConverterFromJson<Object, UnionTimestamp>(
          json['createdAt'], unionTimestampConverter.fromJson),
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'userEmail': instance.userEmail,
      'userEvacuation': instance.userEvacuation,
      'profilePicture': instance.profilePicture,
      'createdAt': _$JsonConverterToJson<Object, UnionTimestamp>(
          instance.createdAt, unionTimestampConverter.toJson),
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
