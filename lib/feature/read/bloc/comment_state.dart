import 'package:kujitoon/feature/read/domain/entities/comment_entity.dart';

abstract class CommentState {}

class LoadingCommentState extends CommentState{}

class LoadedCommentState extends CommentState{
  final List<CommentEntity> listComments;

  LoadedCommentState({required this.listComments});
}

class ErrorCommentState extends CommentState{
  final String message;

  ErrorCommentState({required this.message});
}