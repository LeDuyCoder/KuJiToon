import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/domain/entities/last_chapter_entity.dart';
import 'package:kujitoon/feature/read/domain/entities/chapter_infomation_entity.dart';
import 'package:kujitoon/feature/read/domain/entities/comment_entity.dart';

abstract class ReadRepository {
  Future<ChapterInfomationEntity?> featchData(
    DetailCommicEntity detailComicEntity,
    List<LastChapterEntity> listChapters,
    String urlChapter,
    int currentIndex
  );

  Future<List<CommentEntity>> getAllCommentBySlug(String slug);

  Future<bool> sendCommentBySlug(String slug, CommentEntity comment);
}
