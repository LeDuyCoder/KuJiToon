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
	  isAdmin: comment.data()["isAdmin"],
          userId: comment.data()["userid"],
          userName: comment.data()["username"],
          comment: comment.data()["comment"],
          chapter: comment.data()["chapter"],
          timestamp: comment.data()["create_at"]
      );
    }).toList();
  }


  Future<bool> sendComment(String slug, CommentDto comment) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    bool result = false;

    try{
    	firestore.collection("data")
		    .doc("commics")
		    .collection(slug)
		    .doc("comments")
		    .collection("data")
		    .add(<String, dynamic>{
			"chapter": comment.chapter,
			"comment": comment.comment,
			"create_at": comment.timestamp,
			"userid": comment.userId,
			"username": comment.userName,
			"isAdmin": comment.isAdmin
		    });
	result = true;
    }catch(e){
	result = false;
    }
    return Future.value(result);
  }
}
