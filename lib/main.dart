import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kujitoon/feature/register/data/datasources/register_remote_datasource.dart';
import 'package:kujitoon/feature/register/data/repositories/register_repository_impl.dart';
import 'package:kujitoon/feature/register/domain/repositories/register_reository.dart';
import 'package:kujitoon/feature/register/domain/usecases/register_usecase.dart';
import 'package:kujitoon/feature/register/view/mobile/pages/register_page.dart';

import 'feature/register/bloc/register_bloc.dart';
import 'firebase_options.dart';
import 'core/utils/app_snackbar.dart';

// Splash + Login
import 'feature/splash/view/splash_screen.dart';
import 'feature/auth/view/mobile/pages/login_page.dart';
import 'feature/auth/view/web/pages/login_page.dart' as webAuth;
import 'feature/register/view/web/pages/register_page.dart' as webRegister;

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
  sl.registerLazySingleton(() => RegisterRemoteDatasource(auth: FirebaseAuth.instance));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<RegisterReository>(() => RegisterRepositoryImpl(remote: sl()));

  // UseCase
  sl.registerLazySingleton(() => LoginUsecase(repository: sl()));
  sl.registerLazySingleton(() => RegisterUsecase(repository: sl()));

  // Bloc
  sl.registerFactory(() => AuthBloc(loginUseCase: sl()));
  sl.registerFactory(() => RegisterBloc(registerUsecase: sl()));
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
        //========/ Mobile /=========//

        '/splash': (context) => SplashScreen(),

        '/loginMobile': (context) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: LoginPage(),
        ),

        '/registerMobile': (context) => BlocProvider(
          create: (_) => sl<RegisterBloc>(),
          child: RegisterPage(),
        ),

        //========/ Website /=========//

        '/login': (context) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: webAuth.LoginPage(),
        ),

        '/register': (context) => BlocProvider(
          create: (_) => sl<RegisterBloc>(),
          child: webRegister.RegisterPage(),
        )
      },
    );
  }
}
