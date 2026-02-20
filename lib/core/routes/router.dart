import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/core/routes/auth_gate.dart';
import 'package:kujitoon/feature/auth/bloc/auth_bloc.dart';
import 'package:kujitoon/feature/auth/data/datasources/auth_remote_datasource.dart';
import 'package:kujitoon/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:kujitoon/feature/auth/domain/usecases/login_usecase.dart';
import 'package:kujitoon/feature/details/bloc/detail_bloc.dart';
import 'package:kujitoon/feature/details/bloc/detail_event.dart';
import 'package:kujitoon/feature/details/data/datasource/detail_firebase_datasource.dart';
import 'package:kujitoon/feature/details/data/datasource/detail_local_datasource.dart';
import 'package:kujitoon/feature/details/data/datasource/detail_remote_datasource.dart';
import 'package:kujitoon/feature/details/data/repositories/detail_repository_impl.dart';
import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/domain/entities/last_chapter_entity.dart';
import 'package:kujitoon/feature/details/domain/usecase/detail_commic_usecase.dart';
import 'package:kujitoon/feature/details/view/website/pages/detail_page.dart';
import 'package:kujitoon/feature/home/bloc/home_bloc.dart';
import 'package:kujitoon/feature/home/bloc/home_event.dart';
import 'package:kujitoon/feature/home/data/datasource/home_datasource.dart';
import 'package:kujitoon/feature/home/data/repositories/home_repositories_impl.dart';
import 'package:kujitoon/feature/home/domain/entities/user_entity.dart';
import 'package:kujitoon/feature/home/domain/usecase/fetch_data_usecase.dart';
import 'package:kujitoon/feature/home/view/website/pages/home_page.dart';
import 'package:kujitoon/feature/read/bloc/comment_bloc.dart';
import 'package:kujitoon/feature/read/bloc/comment_event.dart';
import 'package:kujitoon/feature/read/bloc/read_bloc.dart';
import 'package:kujitoon/feature/read/bloc/read_event.dart';
import 'package:kujitoon/feature/read/data/datasource/read_datasource.dart';
import 'package:kujitoon/feature/read/data/repositories/read_repository_impl.dart';
import 'package:kujitoon/feature/read/domain/usecase/load_comment_usecase.dart';
import 'package:kujitoon/feature/read/domain/usecase/read_usecase.dart';
import 'package:kujitoon/feature/read/domain/usecase/send_comment_usecase.dart';
import 'package:kujitoon/feature/read/view/website/pages/read_page.dart';

import 'package:kujitoon/feature/register/bloc/register_bloc.dart';
import 'package:kujitoon/feature/register/data/datasources/register_remote_datasource.dart';
import 'package:kujitoon/feature/register/data/repositories/register_repository_impl.dart';
import 'package:kujitoon/feature/register/domain/usecases/register_usecase.dart';
import 'package:kujitoon/feature/splash/view/splash_screen.dart';

// ignore: library_prefixes
import 'package:kujitoon/feature/auth/view/mobile/pages/login_page.dart' as MobileLogin;
// ignore: library_prefixes
import 'package:kujitoon/feature/auth/view/web/pages/login_page.dart' as WebLogin;
// ignore: library_prefixes
import 'package:kujitoon/feature/register/view/mobile/pages/register_page.dart' as MobileRegister;
// ignore: library_prefixes
import 'package:kujitoon/feature/register/view/web/pages/register_page.dart' as WebRegister;

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> get routes {
    return {
      '/authGate': (_) => const AuthGate(),
      '/splash': (_) => const SplashScreen(),

      '/loginMobile': (_) =>
          BlocProvider(
            create: (_) =>
                AuthBloc(
                  loginUseCase: LoginUsecase(
                    repository: AuthRepositoryImpl(
                        remote: AuthRemoteDatasource()),
                  ),
                ),
            child: MobileLogin.LoginPage(),
          ),

      '/login': (_) =>
          BlocProvider(
            create: (_) =>
                AuthBloc(
                  loginUseCase: LoginUsecase(
                    repository: AuthRepositoryImpl(
                        remote: AuthRemoteDatasource()),
                  ),
                ),
            child: WebLogin.LoginPage(),
          ),

      '/register': (_) =>
          BlocProvider(
            create: (_) =>
                RegisterBloc(
                  registerUsecase: RegisterUsecase(
                    repository: RegisterRepositoryImpl(
                      remote: RegisterRemoteDatasource(),
                    ),
                  ),
                ),
            child: WebRegister.RegisterPage(),
          ),

      '/registerMobile': (_) =>
          BlocProvider(
            create: (_) =>
                RegisterBloc(
                  registerUsecase: RegisterUsecase(
                    repository: RegisterRepositoryImpl(
                      remote: RegisterRemoteDatasource(),
                    ),
                  ),
                ),
            child: MobileRegister.RegisterPage(),
          ),

      '/home': (_) =>
          BlocProvider(
            create: (_) =>
            HomeBloc(
              fetchDataUsecase: FetchDataUsecase(
                repository: HomeRepositoriesImpl(
                  datasource: HomeDatasource(),
                ),
              ),
            )
              ..add(FetchHomeDataEvent()),
            child: HomePage(),
          ),
    };
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '');

    if (uri.path == '/detail') {
      final params = uri.queryParameters;

      final slug = params['slug']!;
      final userEntity = UserEntity.fromQueryParams(params);

      return MaterialPageRoute(
        settings: settings,
        builder: (_) => BlocProvider(
          create: (_) => DetailBloc(
            detailCommicUsecase: DetailCommicUsecase(
              repository: DetailRepositoryImpl(
                remoteSource: DetailRemoteDatasource(),
                firebaseSource: DetailFirebaseDatasource(),
                localSource: DetailLocalDatasource(),
              ),
            ),
          )..add(FetchDataDetailEvent(slug: slug)),
          child: DetailPage(userEntity: userEntity),
        ),
      );
    }else{
      switch(uri.path){
        case "/read":
          final params = uri.queryParameters;
          final slug = params['slug']!;
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) =>
                    ReadBloc(
                      readUsecase: ReadUsecase(
                        repository:
                        ReadRepositoryImpl(resource: ReadDatasource()),
                      ),
                    )
                      ..add(
                        FeatchDataReadWebsiteEvent(
                            keyPageLoad: "READ_PAYLOAD"
                        ),
                      ),
                  ),
                  BlocProvider(
                    create: (_) =>
                    CommentBloc(
                      loadCommentUsecase: LoadCommentUsecase(
                        repository:
                        ReadRepositoryImpl(resource: ReadDatasource()),
                      ),
                      sendCommentUsecase: SendCommentUsecase(
                        repository:
                        ReadRepositoryImpl(resource: ReadDatasource()),
                      ),
                    )
                      ..add(
                        LoadCommentEvent(
                          slug: slug,
                        ),
                      ),
                  ),
                ],
                child: ReadPage()
            )
          );
      }
    }

    return null;
  }
}
