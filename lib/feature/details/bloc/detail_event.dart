import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';

abstract class DetailEvent {}

class FetchDataDetailEvent implements DetailEvent{
  final String slug;

  FetchDataDetailEvent({required this.slug});
}

class UpdateChapterReadEvent implements DetailEvent{
  final String slug;
  final String chapter;
  final int indexChapter;

  UpdateChapterReadEvent({required this.chapter, required this.slug, required this.indexChapter});
}

class IncreaseViewEvent implements DetailEvent{
  final DetailCommicEntity detailCommicEntity;

  IncreaseViewEvent({required this.detailCommicEntity});
}