import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'public_user_model.freezed.dart';
part 'public_user_model.g.dart';

@freezed
class PublicUser with _$PublicUser {
  const factory PublicUser({
    //@JsonKey(ignore: true) String? id,
    @JsonKey(includeIfNull: false) String? id,
    required String name,
    required String avatarUrl,
  }) = _PublicUser;

  factory PublicUser.fromJson(Map<String, dynamic> json) =>
      _$PublicUserFromJson(json);

  factory PublicUser.fromDoc(DocumentSnapshot doc) => PublicUser.fromJson(
        (doc.data() ?? <String, Object?>{}) as Map<String, Object?>,
      ).copyWith(id: doc.id);
}
