import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/domain/entities/last_chapter_entity.dart';
import 'package:kujitoon/feature/read/domain/entities/chater_entity.dart';

class ChapterInfomationEntity {
  final List<LastChapterEntity> listChapters;
  final DetailCommicEntity detailCommicEntity;
  final ChapterEntity chapterEntity;
  final int currentIndex;

  ChapterInfomationEntity({required this.listChapters, required this.chapterEntity, required this.detailCommicEntity, required this.currentIndex});
}