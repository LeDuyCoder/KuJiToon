import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/feature/read/bloc/comment_event.dart';
import 'package:kujitoon/feature/read/bloc/comment_state.dart';
import 'package:kujitoon/feature/read/domain/entities/comment_entity.dart';
import 'package:kujitoon/feature/read/domain/usecase/load_comment_usecase.dart';
import 'package:kujitoon/feature/read/domain/usecase/send_comment_usecase.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState>{
  final LoadCommentUsecase loadCommentUsecase;
  final SendCommentUsecase sendCommentUsecase;

  CommentBloc({required this.loadCommentUsecase, required this.sendCommentUsecase}) : super(LoadingCommentState()) {
    on<LoadCommentEvent>(_onLoad);
    on<SendCommentEvent>(_onSendComment);
  }

  Future<void> _onLoad(LoadCommentEvent event, Emitter emit) async {
    emit(LoadingCommentState());

    try{
      List<CommentEntity> comments = await loadCommentUsecase.loadAllComment(event.slug);
      comments.sort((CommentEntity c1, CommentEntity c2)=>c2.compareTo(c1));
      emit(LoadedCommentState(listComments: comments));
    }catch(e){
      emit(ErrorCommentState(message: e.toString()));
    }

  }

  Future<void> _onSendComment(SendCommentEvent event, Emitter emit) async {
    emit(LoadingCommentState());
    try{
	CommentEntity? commentEntity = await this.sendCommentUsecase.call(event.slug, event.comment, event.chapter);
	if(commentEntity != null){
	 List<CommentEntity> listComments = event.oldState.listComments;
	 listComments.add(commentEntity);
	 event.oldState.listComments.sort((c1, c2)=>c2.compareTo(c1));
	 emit(LoadedCommentState(listComments: listComments));
	}
    }catch(e){
	emit(ErrorCommentState(message: e.toString()));
    }
  }
}
