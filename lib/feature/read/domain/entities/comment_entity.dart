class CommentEntity implements Comparable<CommentEntity>{
  final String userId;
  final String userName;
  final String comment;
  final int chapter;
  final DateTime dateTime;
  final bool isAdmin;

  CommentEntity({required this.isAdmin, required this.userId, required this.userName, required this.comment, required this.chapter, required this.dateTime});

  @override
  int compareTo(other) {
    return dateTime.compareTo(other.dateTime);
  }
}
