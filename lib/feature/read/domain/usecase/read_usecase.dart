import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/domain/entities/last_chapter_entity.dart';
import 'package:kujitoon/feature/read/domain/entities/chapter_infomation_entity.dart';
import 'package:kujitoon/feature/read/domain/repositories/read_repository.dart';

class ReadUsecase {
  final ReadRepository repository;

  ReadUsecase({required this.repository});

  Future<ChapterInfomationEntity?> featchData(
    DetailCommicEntity detailComicEntity,
    List<LastChapterEntity> listChapters,
    String urlChapter,
    int currentIndex,
  ) async {
    return repository.featchData(detailComicEntity, listChapters, urlChapter, currentIndex);
  }
}
