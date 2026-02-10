abstract class CommentEvent {}

class LoadCommentEvent extends CommentEvent{
  final String slug;

  LoadCommentEvent({required this.slug});
}