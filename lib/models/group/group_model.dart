import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduate_app/utils/json_converters/union_timestamp.dart';

part 'group_model.freezed.dart';
part 'group_model.g.dart';

@freezed
class GroupModel with _$GroupModel {
  const factory GroupModel({
    @Default('') String groupId,
    @Default('') String groupName,
    @Default(<String>[]) List<String> members,
    @Default(<String>[]) List<String> mods,
    @unionTimestampConverter required UnionTimestamp createdAt,
  }) = _GroupModel;

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);

  factory GroupModel.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;

    return GroupModel.fromJson(<String, dynamic>{
      ...data,
      'groupId': ds.id,
    });
  }

  const GroupModel._();
}
