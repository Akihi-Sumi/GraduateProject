import 'package:fpdart/fpdart.dart';

class Failure {
  final String message;

  Failure(this.message);
}

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
