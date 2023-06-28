import 'package:graduate_app/models/models.dart';

const String _defautlErrorMessage = 'Something went wrong!';

String exceptionHandler(Exception exception) {
  if (exception is CustomException) {
    return exception.maybeMap(
      authSignUpWithEmailPassword: (e) {
        switch (e.code) {
          case 'email-in-use':
            return 'Email already in use.';
          default:
            return _defautlErrorMessage;
        }
      },
      authSignInWithEmailPassword: (e) {
        switch (e.code) {
          case 'incorrect-email-or-password':
            return 'Email or password was incorrect.';
          default:
            return _defautlErrorMessage;
        }
      },
      orElse: () => _defautlErrorMessage,
    );
  }
  return _defautlErrorMessage;
}
