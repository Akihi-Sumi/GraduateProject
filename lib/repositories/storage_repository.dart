import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:graduate_app/models/custom_exception_model.dart';

class StorageRepository {
  StorageRepository({
    FirebaseStorage? firebaseStorage,
  }) : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  final FirebaseStorage _firebaseStorage;

  static const String imagesFolderName = 'images';

  Future<String> uploadImage({
    required String path,
    required String imgId,
    required File file,
  }) async {
    try {
      final uploadSnaphot = await _firebaseStorage
          .ref('$imagesFolderName/$path/$imgId.jpg')
          .putFile(file);

      return await uploadSnaphot.ref.getDownloadURL();
    } catch (_) {
      throw const UploadImageException();
    }
  }
}
