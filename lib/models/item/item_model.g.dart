// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemModelImpl _$$ItemModelImplFromJson(Map<String, dynamic> json) =>
    _$ItemModelImpl(
      itemId: json['itemId'] as String? ?? '',
      expirationDate: json['expirationDate'] as String? ?? '',
      name: json['name'] as String? ?? '',
      isChecked: json['isChecked'] as bool? ?? false,
      time: json['time'] as int? ?? 0,
    );

Map<String, dynamic> _$$ItemModelImplToJson(_$ItemModelImpl instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'expirationDate': instance.expirationDate,
      'name': instance.name,
      'isChecked': instance.isChecked,
      'time': instance.time,
    };
