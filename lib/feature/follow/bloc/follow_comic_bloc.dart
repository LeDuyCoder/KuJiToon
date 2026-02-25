import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/feature/follow/bloc/follow_comic_event.dart';
import 'package:kujitoon/feature/follow/bloc/follow_comic_state.dart';
import 'package:kujitoon/feature/follow/domain/usecase/get_follow_comic_page_usecase.dart';

class FollowComicBloc extends Bloc<FollowComicEvent, FollowComicState>{
  final GetFollowComicPageUsecase getFollowComicPageUsecase;
  
  FollowComicBloc({required this.getFollowComicPageUsecase}) : super(LoadingFollowComicState()){
    on<FeatchFollowComicByPageEvent>(_onFeatchFollowComicByPageEvent);
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
  
}