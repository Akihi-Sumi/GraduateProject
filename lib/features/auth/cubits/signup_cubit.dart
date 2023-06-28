import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduate_app/app/app_locator.dart';
import 'package:graduate_app/models/models.dart';
import 'package:graduate_app/repositories/repositories.dart';

part 'signup_cubit.freezed.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({
    AuthRepository? authRepository,
    UserRepository? userRepository,
    StorageRepository? storageRepository,
  })  : _authRepository = authRepository ?? locator.get<AuthRepository>(),
        _userRepository = userRepository ?? locator.get<UserRepository>(),
        _storageRepository =
            storageRepository ?? locator.get<StorageRepository>(),
        super(const _SignupInitial());

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final StorageRepository _storageRepository;

  void updateFile(File? file) => emit(
        _SignupInitial(
          file: file,
          name: state.name,
          email: state.email,
          password: state.password,
        ),
      );

  void updateName(String name) => emit(
        _SignupInitial(
          file: state.file,
          name: name.trim(),
          email: state.email,
          password: state.password,
        ),
      );

  void updateEmail(String email) => emit(
        _SignupInitial(
          file: state.file,
          name: state.name,
          email: email.trim(),
          password: state.password,
        ),
      );

  void updatePassword(String password) => emit(
        _SignupInitial(
          file: state.file,
          name: state.name,
          email: state.email,
          password: password,
        ),
      );

  Future<void> signUp() async {
    try {
      emit(
        _SignupSubmitting(
          file: state.file,
          name: state.name,
          email: state.email,
          password: state.password,
        ),
      );
      if (state.file != null) {
        final user = await _authRepository.signUpWithEmailAndPassword(
          email: state.email,
          password: state.password,
        );

        if (user != null) {
          final avatarUrl = await _storageRepository.uploadImage(
            path: user.uid,
            imgId: 'avatar',
            file: state.file!,
          );

          await _userRepository.createPublicUser(
            user: PublicUser(
              id: user.uid,
              name: state.name,
              avatarUrl: avatarUrl,
            ),
          );
          await _userRepository.createPrivateUser(
            user: PrivateUser(
              id: user.uid,
              email: state.email,
              tokens: [],
            ),
          );

          await _userRepository.saveTokenToPrivateUser();
        }
      }
    } on Exception catch (e) {
      emit(
        _SignupError(
          file: state.file,
          name: state.name,
          email: state.email,
          password: state.password,
          exception: e,
        ),
      );
    }
  }
}
