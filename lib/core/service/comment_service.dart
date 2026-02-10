import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kujitoon/core/model/chapter_dto.dart';
import 'package:kujitoon/core/model/comment_dto.dart';
import 'package:kujitoon/core/service/base_service.dart';

class CommentService implements BaseService<List<CommentDto>, String> {
  @override
  Future<List<CommentDto>> call(String slug) async {
    final doc = await FirebaseFirestore.instance
        .collection('data')
        .doc('commics')
        .collection(slug)
        .doc("comments")
        .collection("data")
        .get();
    
    return doc.docs.map((comment) {
      return CommentDto(
          userId: comment.data()["userid"],
          userName: comment.data()["username"],
          comment: comment.data()["comment"],
          chapter: comment.data()["chapter"],
          timestamp: comment.data()["create_at"]
      );
    }).toList();
  }
}