import 'package:kujitoon/core/model/chapter_dto.dart';
import 'package:kujitoon/core/model/comment_dto.dart';
import 'package:kujitoon/core/service/chapter_service.dart';
import 'package:kujitoon/core/service/comment_service.dart';
import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/domain/entities/last_chapter_entity.dart';
import 'package:kujitoon/feature/read/domain/entities/chapter_infomation_entity.dart';
import 'package:kujitoon/feature/read/domain/entities/chater_entity.dart';
import 'package:kujitoon/feature/read/domain/entities/comment_entity.dart';

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
          userId: comment.userId,
          userName: comment.userName,
          comment: comment.comment,
          chapter: comment.chapter,
          dateTime: comment.timestamp.toDate()
      );
    }).toList());

    return comments;
  }
}
