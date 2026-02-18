import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:kujitoon/feature/read/domain/entities/comment_entity.dart';
import 'package:kujitoon/feature/read/domain/repositories/read_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendCommentUsecase {
  final ReadRepository repository;

  SendCommentUsecase({ required this.repository });

  Future<CommentEntity?> call(String slug, String comment, int chapter) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String userName = jsonDecode(pref.getString("user")??"")["name"];
    bool isAdmin = jsonDecode(pref.getString("user")??"")["admin"];

    CommentEntity commentEntity = CommentEntity(
	    isAdmin: isAdmin,
	    userId: userId, 
	    userName: userName, 
	    comment: comment, 
	    chapter: chapter, 
	    dateTime: DateTime.now()
	);

    bool isCommented = await repository.sendCommentBySlug(slug, commentEntity);
    return isCommented ? commentEntity : null;
  }
}
