import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// final emailProvider = StateProvider.autoDispose((ref) {
//   return TextEditingController(text: '');
// });

final editEmailProvider = StateNotifierProvider<EditEmailState, dynamic>((ref) {
  return EditEmailState(ref);
});

class EditEmailState extends StateNotifier<dynamic> {
  final Ref _ref;

  EditEmailState(this._ref) : super([]);

  Future<void> emailUpdate(String newEmail) async {
    final ref = await _ref
        .read(firebaseAuthProvider)
        .currentUser
        ?.updateEmail(newEmail);
  }
}
