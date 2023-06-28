import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduate_app/app/app_locator.dart';
import 'package:graduate_app/models/models.dart';
import 'package:graduate_app/repositories/repositories.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    AuthRepository? authRepository,
    UserRepository? userRepository,
  })  : _authRepository = authRepository ?? locator.get<AuthRepository>(),
        _userRepository = userRepository ?? locator.get<UserRepository>(),
        super(const _AuthUnauthenticated()) {
    _authUserChangesSubscription =
        _authRepository.userChanges.listen((user) => userChanged(user: user));
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  late StreamSubscription<firebase_auth.User?> _authUserChangesSubscription;

  @override
  Future<void> close() {
    _authUserChangesSubscription.cancel();
    return super.close();
  }

  Future<void> userChanged({firebase_auth.User? user}) async {
    try {
      if (user != null) {
        await _userRepository.saveTokenToPrivateUser();
      }
      emit(_AuthAuthenticated(user: user));
    } on SaveTokenException {
      log('[AuthBloc] userChanged: SaveTokenException()');
    }
  }

  Future<void> signOut() async {
    try {
      await _userRepository.removeTokenFromPrivateUser();
      await _authRepository.signOut();
    } on RemoveTokenException {
      await _authRepository.signOut();
    } on Exception catch (e) {
      emit(_AuthUnauthenticated(exception: e));
    }
  }
}
