// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PrivateUser _$$_PrivateUserFromJson(Map<String, dynamic> json) =>
    _$_PrivateUser(
      id: json['id'] as String?,
      email: json['email'] as String,
      tokens:
          (json['tokens'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_PrivateUserToJson(_$_PrivateUser instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['email'] = instance.email;
  val['tokens'] = instance.tokens;
  return val;
}
