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
      createdAt: unionTimestampConverter.fromJson(json['createdAt'] as Object),
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'userEmail': instance.userEmail,
      'userEvacuation': instance.userEvacuation,
      'profilePicture': instance.profilePicture,
      'createdAt': unionTimestampConverter.toJson(instance.createdAt),
    };
