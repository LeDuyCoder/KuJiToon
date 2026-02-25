import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/feature/follow/bloc/follow_comic_bloc.dart';
import 'package:kujitoon/feature/follow/bloc/follow_comic_event.dart';
import 'package:kujitoon/feature/follow/bloc/follow_comic_state.dart';
import 'package:kujitoon/feature/follow/data/datasource/follow_comic_firebase_datasource.dart';
import 'package:kujitoon/feature/follow/data/datasource/follow_comic_remote_datasource.dart';
import 'package:kujitoon/feature/follow/data/repositories/follow_comic_repository_impl.dart';
import 'package:kujitoon/feature/follow/domain/usecase/get_follow_comic_page_usecase.dart';
import 'package:kujitoon/feature/follow/view/website/widget/web/detail_comic_widget.dart';
import 'package:kujitoon/feature/follow/view/website/widget/web/no_follow_widget.dart';
import 'package:kujitoon/feature/home/domain/entities/user_entity.dart';
import 'package:kujitoon/feature/home/view/website/widgets/pagination_widget.dart';
import 'package:kujitoon/feature/loading/view/widgets/loading_widget.dart';

class FollowComicWebWidget extends StatefulWidget{
  final UserEntity userEntity;

  int page = 1;

  FollowComicWebWidget({super.key, required this.userEntity});

  @override
  State<StatefulWidget> createState() => _FollowComicWebWidget();
}

class _FollowComicWebWidget extends State<FollowComicWebWidget>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FollowComicBloc(
          getFollowComicPageUsecase: GetFollowComicPageUsecase(
            repository: FollowComicRepositoryImpl(
                followComicFirebaseDatasource: FollowComicFirebaseDatasource(),
                followComicRemoteDatasource: FollowComicRemoteDatasource()
            )
          )
      )..add(FeatchFollowComicByPageEvent(widget.page-1)),
      child: BlocBuilder<FollowComicBloc, FollowComicState>(
        builder: (context, state){
          if(state is LoadingFollowComicState){
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingWidget(imageAsset: "assets/img/mascot/pic2.png"),
                ],
              ),
            );
          }

          if(state is LoadedFollowComicState){
            print(widget.page);
            return Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // 🔥 cực kỳ quan trọng
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

                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: state.listFollowedComics.map((comic) {
                          return SizedBox(
                            width: 190,
                            child: DetailComicCard(
                              detailCommicEntity: comic,
                              userEntity: widget.userEntity,
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    PaginationWidget(currentPage: widget.page, totalPages: (state.totalComics / 5).ceil(), onPageChanged: (int value) {
                      context.read<FollowComicBloc>().add(FeatchFollowComicByPageEvent(value-1));
                      setState(() {
                        widget.page = value;
                      });
                    },)
                  ],
                ),
              ),
            );
          }

          if(state is EmptyFollowComicState){
            return NoFollowWidget();
          }

          return Center(
            child: Text(state.toString()),
          );
        },
      )
    );
  }
}

