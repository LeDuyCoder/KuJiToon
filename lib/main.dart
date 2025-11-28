import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:kujitoon/feature/auth/view/mobile/pages/login_page.dart';
import 'package:kujitoon/feature/splash/view/splash_screen.dart';
import 'package:kujitoon/firebase_options.dart';

import 'feature/auth/bloc/auth_bloc.dart';
import 'feature/auth/data/datasources/auth_remote_datasource.dart';
import 'feature/auth/data/repositories/auth_repository_impl.dart';
import 'feature/auth/domain/repositories/auth_repository.dart';
import 'feature/auth/domain/usecases/login_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  // Datasource
  final firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => AuthRemoteDatasource(FirebaseAuth.instance));

  // Repository (register theo interface)
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // UseCase
  sl.registerLazySingleton(() => LoginUsecase(repository: sl<AuthRepository>()));

  // Bloc
  sl.registerFactory(() => AuthBloc(loginUseCase: sl<LoginUsecase>()));
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const KuJiToonApp(),
    );
  }
}

class KuJiToonApp extends StatelessWidget{
  const KuJiToonApp({super.key});

  @override
  Widget build(BuildContext context) {

    Widget initialScreen;

    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) {
      initialScreen = SplashScreen();
    } else {
      // Android/iOS → show SplashScreen
      initialScreen = SplashScreen();
    }



    return MaterialApp(
      title: 'KuJiToon',
      home: initialScreen,
      routes: {
        '/loginMobile': (context) => BlocProvider(
          create: (_) => sl<AuthBloc>(), // lấy AuthBloc từ GetIt, đã có sẵn LoginUsecase
          child: LoginPage(),      // widget UI con giữ state
        ),
      },
    );
  }
}
