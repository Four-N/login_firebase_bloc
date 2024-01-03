import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:local_storage_todos_api/local_storage_todos_api.dart';

import 'package:login_firebase_bloc/app/bloc_observer.dart';
import 'package:login_firebase_bloc/app/view/app.dart';
import 'package:todos_repository/todos_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final todosApi = LocalStorageTodosApi(
    plugin: await SharedPreferences.getInstance(),
  );

  final todosRepository = TodosRepository(todosApi: todosApi);
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  runApp(App(
    authenticationRepository: authenticationRepository,
    todosRepository: todosRepository,
  ));
}
