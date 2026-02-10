import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/feature/read/bloc/comment_event.dart';
import 'package:kujitoon/feature/read/bloc/comment_state.dart';
import 'package:kujitoon/feature/read/domain/entities/comment_entity.dart';
import 'package:kujitoon/feature/read/domain/usecase/load_comment_usecase.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState>{
  final LoadCommentUsecase loadCommentUsecase;

  CommentBloc({required this.loadCommentUsecase}) : super(LoadingCommentState()) {
    on<LoadCommentEvent>(_onLoad);
  }

  Future<void> _onLoad(LoadCommentEvent event, Emitter emit) async {
    emit(LoadingCommentState());

    try{
      List<CommentEntity> comments = await loadCommentUsecase.loadAllComment(event.slug);
      emit(LoadedCommentState(listComments: comments));
    }catch(e){
      emit(ErrorCommentState(message: e.toString()));
    }

  }
}