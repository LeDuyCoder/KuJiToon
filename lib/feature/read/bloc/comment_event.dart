import 'package:kujitoon/feature/read/bloc/comment_state.dart';

abstract class CommentEvent {}

class LoadCommentEvent extends CommentEvent{
  final String slug;

  LoadCommentEvent({required this.slug});
}

class SendCommentEvent extends CommentEvent{
  final String slug;
  final int chapter;
  final String comment;
  final LoadedCommentState oldState;

  SendCommentEvent(this.slug, this.chapter, this.comment, this.oldState);

}
