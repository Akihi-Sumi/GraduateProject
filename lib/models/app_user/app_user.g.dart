// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUser _$$_AppUserFromJson(Map<String, dynamic> json) => _$_AppUser(
      userId: json['userId'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      userEmail: json['userEmail'] as String? ?? '',
      createdAt: unionTimestampConverter.fromJson(json['createdAt'] as Object),
    );

Map<String, dynamic> _$$_AppUserToJson(_$_AppUser instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'userEmail': instance.userEmail,
      'createdAt': unionTimestampConverter.toJson(instance.createdAt),
    };
