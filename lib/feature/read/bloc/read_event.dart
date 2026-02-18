import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/domain/entities/last_chapter_entity.dart';

abstract class ReadEvent {}

class FeatchDataReadEvent extends ReadEvent {
  final DetailCommicEntity detailComicEntity;
  final List<LastChapterEntity> listChapters;
  final String urlChapter;
  final int currentIndex;

  FeatchDataReadEvent({
    required this.listChapters,
    required this.urlChapter,
    required this.detailComicEntity,
    required this.currentIndex,
  });
}
