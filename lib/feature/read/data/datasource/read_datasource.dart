import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kujitoon/core/model/chapter_dto.dart';
import 'package:kujitoon/core/model/comment_dto.dart';
import 'package:kujitoon/core/service/chapter_service.dart';
import 'package:kujitoon/core/service/comment_service.dart';
import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/domain/entities/last_chapter_entity.dart';
import 'package:kujitoon/feature/read/domain/entities/chapter_infomation_entity.dart';
import 'package:kujitoon/feature/read/domain/entities/chater_entity.dart';
import 'package:kujitoon/feature/read/domain/entities/comment_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadDatasource {
  Future<ChapterInfomationEntity?> feachData(
    DetailCommicEntity detailComicEntity,
    List<LastChapterEntity> listChapters,
    String urlChapter,
    int currentIndex
  ) async
  {
    ChapterService chapterService = ChapterService();
    ChapterDto? chapterDTO = await chapterService.call(urlChapter);

    ChapterInfomationEntity? chapterInfomationEntity;

    if (chapterDTO != null) {
      chapterInfomationEntity = ChapterInfomationEntity(
        listChapters: listChapters,
        chapterEntity: ChapterEntity(
          domainCDN: chapterDTO.domainCDN,
          chapterPath: chapterDTO.chapterPath,
          listChapterImages: chapterDTO.listChapterImages,
          chapterName: chapterDTO.chapterName,
        ),
        detailCommicEntity: detailComicEntity,
        currentIndex: currentIndex,
      );
    }
    return chapterInfomationEntity;
  }

  Future<List<CommentEntity>> getAllCommentBySlug(String slug) async {
    CommentService commentService = CommentService();
    List<CommentDto> commentsDTO = await commentService.call(slug);
    List<CommentEntity> comments = [];

    comments.addAll(commentsDTO.map((comment){
      return CommentEntity(
	  isAdmin: comment.isAdmin,
          userId: comment.userId,
          userName: comment.userName,
          comment: comment.comment,
          chapter: comment.chapter,
          dateTime: comment.timestamp.toDate()
      );
    }).toList());

    return comments;
  }

  Future<bool> sendCommentBySlug(String slug, CommentEntity comment) async {
    CommentService commentService = CommentService();
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool result = false;

    CommentDto commentDto = CommentDto(
	    userId: comment.userId, 
	    userName: comment.userName, 
	    comment: comment.comment, 
	    chapter: comment.chapter, 
	    timestamp: Timestamp.fromDate(comment.dateTime), 
	    isAdmin: jsonDecode(pref.getString("user")??"")["admin"],
	);

    result = await commentService.sendComment(slug, commentDto);
    return Future.value(result);
  }
}
