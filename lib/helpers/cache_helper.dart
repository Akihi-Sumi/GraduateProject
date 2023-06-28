import 'package:graduate_app/models/models.dart';

class CacheHelper {
  final Map<String, PublicUser> _userMap = {};

  void addPublicUser({required PublicUser publicUser}) {
    if (publicUser.id != null) {
      _userMap[publicUser.id!] = publicUser;
    }
  }

  PublicUser? retrievePublicUser({required String id}) {
    if (_userMap.containsKey(id)) {
      return _userMap[id];
    }
    return null;
  }
}
