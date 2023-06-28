part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.unauthenticated({Exception? exception}) =
      _AuthUnauthenticated;

  const factory AuthState.authenticated({required firebase_auth.User? user}) =
      _AuthAuthenticated;
}
