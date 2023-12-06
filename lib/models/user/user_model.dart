import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';

@FirestoreDocument(path: 'user', documentName: 'user')
class User {
  const User({
    required this.imageUrl,
    required this.userName,
    required this.userEmail,
    required this.userEvacuation,
    required this.introduction,
    this.createdAt,
    this.updatedAt,
  });

  @ReadDefault('')
  @CreateDefault('')
  final String imageUrl;

  @ReadDefault('')
  final String userName;

  @ReadDefault('')
  final String userEmail;

  @ReadDefault('')
  final String userEvacuation;

  @ReadDefault('')
  final String introduction;

  @AlwaysUseFieldValueServerTimestampWhenCreating()
  final DateTime? createdAt;

  @AlwaysUseFieldValueServerTimestampWhenCreating()
  @AlwaysUseFieldValueServerTimestampWhenUpdating()
  final DateTime? updatedAt;
}

class ReadUser {
  const ReadUser({
    required this.userId,
    required this.path,
    required this.imageUrl,
    required this.userName,
    required this.userEmail,
    required this.userEvacuation,
    required this.introduction,
    required this.createdAt,
    required this.updatedAt,
  });

  final String userId;
  final String path;
  final String imageUrl;
  final String userName;
  final String userEmail;
  final String userEvacuation;
  final String introduction;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ReadUser._fromJson(Map<String, dynamic> json) {
    return ReadUser(
      userId: json['userId'] as String,
      path: json['path'] as String,
      imageUrl: json['imageUrl'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      userEmail: json['userEmail'] as String? ?? '',
      userEvacuation: json['userEvacuation'] as String? ?? '',
      introduction: json['introduction'] as String? ?? '',
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  factory ReadUser.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return ReadUser._fromJson(<String, dynamic>{
      ...data,
      'userId': ds.id,
      'path': ds.reference.path,
    });
  }
}

class UpdateUser {
  const UpdateUser({
    this.profilePicture,
    this.userName,
    this.userEmail,
    this.userEvacuation,
    this.createdAt,
  });

  final String? profilePicture;
  final String? userName;
  final String? userEmail;
  final String? userEvacuation;
  final DateTime? createdAt;

  Map<String, dynamic> toJson() {
    return {
      if (profilePicture != null) 'profilePicture': profilePicture,
      if (userName != null) 'userName': userName,
      if (userEmail != null) 'userEmail': userEmail,
      if (userEvacuation != null) 'userEvacuation': userEvacuation,
      if (createdAt != null) 'createdAt': createdAt,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
