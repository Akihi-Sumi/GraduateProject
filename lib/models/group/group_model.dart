import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_model.freezed.dart';
part 'group_model.g.dart';

@freezed
class GroupModel with _$GroupModel {
  const factory GroupModel({
    required String groupId,
    required String groupName,
    required List<String> members,
    required List<String> mods,
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
