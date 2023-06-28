import 'package:get_it/get_it.dart';
import 'package:graduate_app/helpers/helpers.dart';
import 'package:graduate_app/repositories/repositories.dart';

final locator = GetIt.instance;

void setUpLocator() {
  locator
    ..registerSingleton(AuthRepository())
    ..registerSingleton(UserRepository())
    ..registerSingleton(StorageRepository())
    ..registerSingleton(ImageHelper());
}
