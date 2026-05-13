import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/follow/bloc/follow_comic_event.dart';
import 'package:kujitoon/feature/follow/bloc/follow_comic_state.dart';
import 'package:kujitoon/feature/follow/domain/usecase/follow_comic_usecase.dart';
import 'package:kujitoon/feature/follow/domain/usecase/get_follow_comic_page_usecase.dart';

class FollowComicBloc extends Bloc<FollowComicEvent, FollowComicState>{
  final GetFollowComicPageUsecase getFollowComicPageUsecase;
  final FollowComicUsecase followComicUsecase;
  
  FollowComicBloc({required this.getFollowComicPageUsecase, required this.followComicUsecase}) : super(LoadingFollowComicState()){
    on<FeatchFollowComicByPageEvent>(_onFeatchFollowComicByPageEvent);
    on<UpdateChapterReadEvent>(_onUpdateChapterRead);
    on<IncreaseViewEvent>(_onIncreaseView);
    on<RemoveFollowComicEvent>(_onRemoveFollowComic);
  }

  Future<void> _onFeatchFollowComicByPageEvent(FeatchFollowComicByPageEvent event, Emitter<FollowComicState> emit) async {
    try {
      emit(LoadingFollowComicState());
      final result = await getFollowComicPageUsecase.call(event.page, event.pageSize);
      final totalComics = await getFollowComicPageUsecase.getTotalFollowComic();
      if(result.isEmpty){
        emit(EmptyFollowComicState());
      } else {
        emit(LoadedFollowComicState(listFollowedComics: result, totalComics: totalComics));
      }
    } catch (e) {
      print(e.toString());
      emit(ErrorFollowComicState(message: e.toString()));
    }
  }

  Future<void> _onUpdateChapterRead(UpdateChapterReadEvent event, Emitter emit) async {
    await followComicUsecase.updateChapterRead(event.slug, event.chapter, event.indexChapter);
  }

  Future<void> _onIncreaseView(IncreaseViewEvent event, Emitter emit) async {
    await followComicUsecase.inscreaseView(event.detailCommicEntity.slug, event.detailCommicEntity.countRead++);
    emit(LoadedFollowComicState(
        listFollowedComics: event.oldLoadedFollowComicState.listFollowedComics,
        totalComics: event.oldLoadedFollowComicState.totalComics
    ));
  }

  Future<void> _onRemoveFollowComic(RemoveFollowComicEvent event, Emitter emit) async {
    try {
      await followComicUsecase.removeFollowComic(event.slug);
      final updatedList = (state as LoadedFollowComicState).listFollowedComics.where((comic) => comic.slug != event.slug).toList();
      emit(LoadedFollowComicState(listFollowedComics: updatedList, totalComics: (state as LoadedFollowComicState).totalComics - 1));
    } catch (e) {
      print(e.toString());
      emit(ErrorFollowComicState(message: e.toString()));
    }
  }
}