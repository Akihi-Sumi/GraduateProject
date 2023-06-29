import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:graduate_app/models/models.dart';

class AuthRepository {
  AuthRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;

  Stream<firebase_auth.User?> get userChanges => _firebaseAuth.userChanges();
  firebase_auth.User? get currentUser => _firebaseAuth.currentUser;

  Future<firebase_auth.User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailPasswordException(code: e.code);
    } catch (_) {
      throw const SignInWithEmailPasswordException();
    }
  }

  Future<firebase_auth.User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (['wrong-password', 'user-not-found'].contains(e.code)) {
        throw const SignInWithEmailPasswordException(
          code: 'incorrect-email-or-password',
        );
      }
      throw const SignInWithEmailPasswordException();
    } catch (_) {
      throw const SignInWithEmailPasswordException();
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {
      throw const SignOutException();
    }
  }
}
