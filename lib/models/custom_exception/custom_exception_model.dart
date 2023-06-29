import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_exception_model.freezed.dart';

@freezed
class CustomException with _$CustomException implements Exception {
  const factory CustomException.authSignUpWithEmailPassword({
    @Default('Error') String code,
  }) = SignUpWithEmailPasswordException;

  const factory CustomException.authSignInWithEmailPassword({
    @Default('Error') String code,
  }) = SignInWithEmailPasswordException;

  const factory CustomException.authSignOut() = SignOutException;

  const factory CustomException.userReadUser() = ReadUserException;
  const factory CustomException.userCreateUser() = CreateUserException;
  const factory CustomException.userSaveToken() = SaveTokenException;
  const factory CustomException.userRemoveToken() = RemoveTokenException;
  const factory CustomException.searchUsersException() = SearchUsersException;

  const factory CustomException.storageUploadImageException() =
      UploadImageException;
}
