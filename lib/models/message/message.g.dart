// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      userId: json['userId'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      messageId: json['messageId'] as String? ?? '',
      type: json['type'] as String? ?? '',
      messageText: json['messageText'] as String? ?? '',
      groupName: json['groupName'] as String? ?? '',
      createdAt: unionTimestampConverter.fromJson(json['createdAt'] as Object),
      updatedAt: alwaysUseServerTimestampUnionTimestampConverter
          .fromJson(json['updatedAt'] as Object),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'messageId': instance.messageId,
      'type': instance.type,
      'messageText': instance.messageText,
      'groupName': instance.groupName,
      'createdAt': unionTimestampConverter.toJson(instance.createdAt),
      'updatedAt': alwaysUseServerTimestampUnionTimestampConverter
          .toJson(instance.updatedAt),
    };
