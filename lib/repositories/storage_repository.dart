import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:graduate_app/utils/failure_type_defs.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final storageProvider = Provider((ref) => FirebaseStorage.instance);

final storageRepositoryProvider = Provider((ref) {
  return StorageRepository(firebaseStorage: ref.watch(storageProvider));
});

class StorageRepository {
  final FirebaseStorage _firebaseStorage;

  StorageRepository({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;

  FutureEither<String> storeFile({
    required String path,
    required String id,
    required File? file,
  }) async {
    try {
      final ref = _firebaseStorage.ref().child(path).child(id);
      UploadTask uploadTask;

      uploadTask = ref.putFile(file!);
      final snapshot = await uploadTask;

      return right(await snapshot.ref.getDownloadURL());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
