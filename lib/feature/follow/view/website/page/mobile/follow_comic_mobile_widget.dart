import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kujitoon/feature/follow/bloc/follow_comic_bloc.dart';
import 'package:kujitoon/feature/follow/bloc/follow_comic_event.dart';
import 'package:kujitoon/feature/follow/bloc/follow_comic_state.dart';
import 'package:kujitoon/feature/follow/data/datasource/follow_comic_firebase_datasource.dart';
import 'package:kujitoon/feature/follow/data/datasource/follow_comic_local_datasource.dart';
import 'package:kujitoon/feature/follow/data/datasource/follow_comic_remote_datasource.dart';
import 'package:kujitoon/feature/follow/data/repositories/follow_comic_repository_impl.dart';
import 'package:kujitoon/feature/follow/domain/usecase/follow_comic_usecase.dart';
import 'package:kujitoon/feature/follow/domain/usecase/get_follow_comic_page_usecase.dart';
import 'package:kujitoon/feature/follow/view/website/widget/detail_comic_widget.dart';
import 'package:kujitoon/feature/follow/view/website/widget/no_follow_widget.dart';
import 'package:kujitoon/feature/home/domain/entities/user_entity.dart';
import 'package:kujitoon/feature/home/view/website/widgets/mobile/footer_widget.dart';
import 'package:kujitoon/feature/home/view/website/widgets/pagination_widget.dart';
import 'package:kujitoon/feature/loading/view/widgets/loading_widget.dart';

class FollowComicMobileWidget extends StatefulWidget {
  final UserEntity userEntity;

  int page = 1;

  FollowComicMobileWidget({super.key, required this.userEntity});

  @override
  State<StatefulWidget> createState() => _FollowComicMobileWidget();
}

class _FollowComicMobileWidget extends State<FollowComicMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            SizedBox(height: 100,),
            BlocProvider(
              create: (_) => FollowComicBloc(
                getFollowComicPageUsecase: GetFollowComicPageUsecase(
                  repository: FollowComicRepositoryImpl(
                    followComicFirebaseDatasource: FollowComicFirebaseDatasource(),
                    followComicRemoteDatasource: FollowComicRemoteDatasource(),
                    followComicLocalDatasource: FollowComicLocalDatasource(),
                  ),
                ),
                followComicUsecase: FollowComicUsecase(
                  repository: FollowComicRepositoryImpl(
                    followComicFirebaseDatasource: FollowComicFirebaseDatasource(),
                    followComicRemoteDatasource: FollowComicRemoteDatasource(),
                    followComicLocalDatasource: FollowComicLocalDatasource(),
                  ),
                ),
              )..add(FeatchFollowComicByPageEvent(widget.page - 1)),
              child: BlocBuilder<FollowComicBloc, FollowComicState>(
                builder: (context, state) {
                  if (state is LoadingFollowComicState) {
                    return Container(
                      width: MediaQuery.sizeOf(context).width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 100,),
                          LoadingWidget(imageAsset: "assets/img/mascot/pic2.png"),
                        ],
                      ),
                    );
                  }

                  if(state is LoadedFollowComicState){
                    return Expanded(
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 250,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  "Truyện đang theo dõi",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Center(
                                child: Wrap(
                                  spacing: 16,
                                  runSpacing: 16,
                                  children: state.listFollowedComics.map((comic) {
                                    return SizedBox(
                                      width: 200,
                                      child: DetailComicCard(
                                        detailCommicEntity: comic,
                                        userEntity: widget.userEntity,
                                        loadedFollowComicState: state,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: PaginationWidget(
                                  currentPage: widget.page,
                                  totalPages: (state.totalComics / 5).ceil(),
                                  onPageChanged: (int value) {
                                    context.read<FollowComicBloc>().add(
                                      FeatchFollowComicByPageEvent(value - 1),
                                    );
                                    setState(() {
                                      widget.page = value;
                                    });
                                  },
                                ),
                              ),
                              FooterWidget()
                            ],
                          ),
                        )
                      )
                    );
                  }

                  if (state is EmptyFollowComicState) {
                    return NoFollowWidget();
                  }

                  return Center(child: Text(state.toString()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
