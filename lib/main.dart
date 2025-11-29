import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';
import 'core/utils/app_snackbar.dart';

// Splash + Login
import 'feature/splash/view/splash_screen.dart';
import 'feature/auth/view/mobile/pages/login_page.dart';
import 'feature/auth/view/web/pages/login_page.dart' as web;

// Clean Architecture layers
import 'feature/auth/bloc/auth_bloc.dart';
import 'feature/auth/data/datasources/auth_remote_datasource.dart';
import 'feature/auth/data/repositories/auth_repository_impl.dart';
import 'feature/auth/domain/repositories/auth_repository.dart';
import 'feature/auth/domain/usecases/login_usecase.dart';

final sl = GetIt.instance;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> setup() async {
  // Datasource
  sl.registerLazySingleton(() => AuthRemoteDatasource(FirebaseAuth.instance));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // UseCase
  sl.registerLazySingleton(() => LoginUsecase(repository: sl()));

  // Bloc
  sl.registerFactory(() => AuthBloc(loginUseCase: sl()));
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
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: AppSnackBar.messengerKey,
      title: 'KuJiToon',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)),
      initialRoute: "/splash",
      routes: {
        '/splash': (context) => SplashScreen(),

        '/loginMobile': (context) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: LoginPage(),
        ),

        '/login': (context) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: web.LoginPage(),
        ),
      },
    );
  }
}
