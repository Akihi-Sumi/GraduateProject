part of 'signup_cubit.dart';

@freezed
class SignupState with _$SignupState {
  const factory SignupState.initial({
    @Default(null) File? file,
    @Default('') String name,
    @Default('') String email,
    @Default('') String password,
  }) = _SignupInitial;

  const factory SignupState.submitting({
    required File? file,
    required String name,
    required String email,
    required String password,
  }) = _SignupSubmitting;

  const factory SignupState.error({
    required File? file,
    required String name,
    required String email,
    required String password,
    required Exception exception,
  }) = _SignupError;
}
