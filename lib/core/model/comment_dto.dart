import 'package:cloud_firestore/cloud_firestore.dart';

class CommentDto {
  final String userId;
  final String userName;
  final String comment;
  final int chapter;
  final Timestamp timestamp;
  final bool isAdmin;

  CommentDto({required this.isAdmin, required this.userId, required this.userName, required this.comment, required this.chapter, required this.timestamp});
}
