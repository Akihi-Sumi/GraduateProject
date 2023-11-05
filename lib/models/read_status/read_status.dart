import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduate_app/utils/json_converters/union_timestamp.dart';

part 'read_status.freezed.dart';
part 'read_status.g.dart';

@freezed
class ReadStatus with _$ReadStatus {
  const factory ReadStatus({
    @Default('') String readStatusId,
    @alwaysUseServerTimestampUnionTimestampConverter DateTime? lastReadAt,
  }) = _ReadStatus;

  factory ReadStatus.fromJson(Map<String, dynamic> json) =>
      _$ReadStatusFromJson(json);

  factory ReadStatus.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;

    return ReadStatus.fromJson(<String, dynamic>{
      ...data,
      'readStatusId': ds.id,
    });
  }

  const ReadStatus._();
}
