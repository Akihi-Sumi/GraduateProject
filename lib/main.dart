import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_app/app/app.dart';
import 'package:graduate_app/app/app_bloc_observer.dart';
import 'package:graduate_app/app/app_locator.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setUpLocator();

  Bloc.observer = AppBlocObserver();

  runApp(App());
}
