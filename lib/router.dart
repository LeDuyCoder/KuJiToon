import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/core/routes/auth_gate.dart';
import 'package:kujitoon/feature/auth/bloc/auth_bloc.dart';
import 'package:kujitoon/feature/auth/data/datasources/auth_remote_datasource.dart';
import 'package:kujitoon/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:kujitoon/feature/auth/domain/usecases/login_usecase.dart';
import 'package:kujitoon/feature/details/bloc/detail_bloc.dart';
import 'package:kujitoon/feature/details/bloc/detail_event.dart';
import 'package:kujitoon/feature/details/data/datasource/detail_datasource.dart';
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
import 'package:kujitoon/feature/read/view/website/pages/web/read_page.dart';

import 'package:kujitoon/feature/register/bloc/register_bloc.dart';
import 'package:kujitoon/feature/register/data/datasources/register_remote_datasource.dart';
import 'package:kujitoon/feature/register/data/repositories/register_repository_impl.dart';
import 'package:kujitoon/feature/register/domain/usecases/register_usecase.dart';
import 'package:kujitoon/feature/splash/view/splash_screen.dart';

import 'package:kujitoon/feature/auth/view/mobile/pages/login_page.dart' as MobileLogin;
import 'package:kujitoon/feature/auth/view/web/pages/login_page.dart' as WebLogin;

import 'package:kujitoon/feature/register/view/mobile/pages/register_page.dart' as MobileRegister;
import 'package:kujitoon/feature/register/view/web/pages/register_page.dart' as WebRegister;
import 'package:universal_html/js.dart';


Map<String, Widget Function(BuildContext context)> get routes {
  return {
    '/authGate': (context) => AuthGate(),

    '/splash': (context) => SplashScreen(),

    //Login Page
    '/loginMobile': (context) => BlocProvider(
      create: (_) => AuthBloc(
          loginUseCase: LoginUsecase(repository: AuthRepositoryImpl(
              remote: AuthRemoteDatasource()
          ))
      ),
      child: MobileLogin.LoginPage(),
    ),

    '/login': (context) => BlocProvider(
      create: (_) => AuthBloc(
          loginUseCase: LoginUsecase(repository: AuthRepositoryImpl(
              remote: AuthRemoteDatasource()
          ))
      ),
      child: WebLogin.LoginPage(),
    ),
    
    //Register Page
    '/register': (context) => BlocProvider(
      create: (_) => RegisterBloc(
          registerUsecase: RegisterUsecase(
              repository: RegisterRepositoryImpl(
                  remote: RegisterRemoteDatasource()
              )
          )
      ),
      child: WebRegister.RegisterPage(),
    ),

    '/registerMobile': (context) => BlocProvider(
      create: (_) => RegisterBloc(
          registerUsecase: RegisterUsecase(
              repository: RegisterRepositoryImpl(
                  remote: RegisterRemoteDatasource()
              )
          )
      ),
      child: MobileRegister.RegisterPage(),
    ),

    //home
    '/home': (context) => BlocProvider(
      create: (_) => HomeBloc(
          fetchDataUsecase: FetchDataUsecase(
              repository: HomeRepositoriesImpl(
                  datasource: HomeDatasource()
              )
          )
      )..add(FetchHomeDataEvent()),
      child: HomePage()
    ),

    //detail
    "/detail": (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final String slug = args['slug'] as String;
      final UserEntity userEntity = args["userEntity"] as UserEntity;

      return BlocProvider(
        create: (_) => DetailBloc(
            detailCommicUsecase: DetailCommicUsecase(
                repository: DetailRepositoryImpl(
                    source: DetailDatasource()
                )
            )
        )..add(FetchDataDetailEvent(slug: slug)),
        child: DetailPage(userEntity: userEntity,),
      );
    },

    //read
    "/read": (context){
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      final List<LastChapterEntity> listChapters = args['chapters'] as List<LastChapterEntity>;
      final String urlChapter = args['urlChapter'] as String;
      final DetailCommicEntity detailComicEntity = args['detailComicEntity'] as DetailCommicEntity;
      final int currentIndexChapter = args["currentIndexChapter"] as int;

      return MultiBlocProvider(
        providers: [
          BlocProvider<ReadBloc>(
            create: (_) => ReadBloc(
              readUsecase: ReadUsecase(
                repository: ReadRepositoryImpl(
                  resource: ReadDatasource(),
                ),
              ),
            )..add(
              FeatchDataReadEvent(
                listChapters: listChapters,
                urlChapter: urlChapter,
                detailComicEntity: detailComicEntity,
                currentIndex: currentIndexChapter,
              ),
            ),
          ),
          BlocProvider<CommentBloc>(
              create: (_) => CommentBloc(
                  loadCommentUsecase: LoadCommentUsecase(
                    repository: ReadRepositoryImpl(resource: ReadDatasource())
                  )
              )..add(LoadCommentEvent(slug: detailComicEntity.slug))
          )
        ],
        child: const ReadPage(),
      );
    }
  };
}