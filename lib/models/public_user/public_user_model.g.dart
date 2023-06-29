// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PublicUser _$$_PublicUserFromJson(Map<String, dynamic> json) =>
    _$_PublicUser(
      id: json['id'] as String?,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String,
    );

Map<String, dynamic> _$$_PublicUserToJson(_$_PublicUser instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  val['avatarUrl'] = instance.avatarUrl;
  return val;
}
