import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/domain/entities/last_chapter_entity.dart';
import 'package:kujitoon/feature/read/data/datasource/read_datasource.dart';
import 'package:kujitoon/feature/read/domain/entities/chapter_infomation_entity.dart';
import 'package:kujitoon/feature/read/domain/entities/comment_entity.dart';
import 'package:kujitoon/feature/read/domain/repositories/read_repository.dart';

class ReadRepositoryImpl implements ReadRepository {
  final ReadDatasource resource;

  ReadRepositoryImpl({required this.resource});

  @override
  Future<ChapterInfomationEntity?> featchData(
    DetailCommicEntity detailComicEntity,
    List<LastChapterEntity> listChapters,
    String urlChapter,
    int currentIndex,
  ) {
    return resource.feachData(
      detailComicEntity,
      listChapters,
      urlChapter,
      currentIndex,
    );
  }

  @override
  Future<List<CommentEntity>> getAllCommentBySlug(String slug) {
    return resource.getAllCommentBySlug(slug);
  }

  @override
  Future<bool> sendCommentBySlug(String slug, CommentEntity comment) {
    return resource.sendCommentBySlug(slug, comment);
  }
}
