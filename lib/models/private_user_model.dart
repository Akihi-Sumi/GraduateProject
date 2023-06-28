import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'private_user_model.freezed.dart';
part 'private_user_model.g.dart';

@freezed
class PrivateUser with _$PrivateUser {
  const factory PrivateUser({
    @JsonKey(includeIfNull: false) String? id,
    required String email,
    required List<String> tokens,
  }) = _PrivateUser;

  factory PrivateUser.fromJson(Map<String, dynamic> json) =>
      _$PrivateUserFromJson(json);

  factory PrivateUser.fromDoc(DocumentSnapshot doc) => PrivateUser.fromJson(
        (doc.data() ?? <String, Object?>{}) as Map<String, Object?>,
      ).copyWith(id: doc.id);
}
