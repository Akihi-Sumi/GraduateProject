import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduate_app/utils/utils.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
    @Default('') String messageId,
    @Default('') String messageText,
    @Default(true) bool active,
    @unionTimestampConverter required UnionTimestamp createdAt,
    @alwaysUseServerTimestampUnionTimestampConverter
    required UnionTimestamp updatedAt,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  factory Message.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;

    return Message.fromJson(<String, dynamic>{
      ...data,
      'messageId': ds.id,
    });
  }

  const Message._();
}
