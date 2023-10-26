// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class GroupModel2 {
  final String groupId;
  final String groupName;
  final List<String> members;
  final List<String> mods;
  GroupModel2({
    required this.groupId,
    required this.groupName,
    required this.members,
    required this.mods,
  });

  GroupModel2 copyWith({
    String? groupId,
    String? groupName,
    List<String>? members,
    List<String>? mods,
  }) {
    return GroupModel2(
      groupId: groupId ?? this.groupId,
      groupName: groupName ?? this.groupName,
      members: members ?? this.members,
      mods: mods ?? this.mods,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'groupId': groupId,
      'groupName': groupName,
      'members': members,
      'mods': mods,
    };
  }

  factory GroupModel2.fromMap(Map<String, dynamic> map) {
    return GroupModel2(
      groupId: map['groupId'] as String,
      groupName: map['groupName'] as String,
      members: List<String>.from(map['members']),
      mods: List<String>.from(map['mods']),
    );
  }

  // String toJson() => json.encode(toMap());

  // factory GroupModel2.fromJson(String source) =>
  //     GroupModel2.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GroupModel2(groupId: $groupId, groupName: $groupName, members: $members, mods: $mods)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupModel2 &&
        other.groupId == groupId &&
        other.groupName == groupName &&
        listEquals(other.members, members) &&
        listEquals(other.mods, mods);
  }

  @override
  int get hashCode {
    return groupId.hashCode ^
        groupName.hashCode ^
        members.hashCode ^
        mods.hashCode;
  }
}
