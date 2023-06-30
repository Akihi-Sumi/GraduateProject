// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Message _$$_MessageFromJson(Map<String, dynamic> json) => _$_Message(
      messageId: json['messageId'] as String? ?? '',
      messageText: json['messageText'] as String? ?? '',
      active: json['active'] as bool? ?? true,
    );

Map<String, dynamic> _$$_MessageToJson(_$_Message instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'messageText': instance.messageText,
      'active': instance.active,
    };
