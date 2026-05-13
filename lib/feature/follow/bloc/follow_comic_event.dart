import 'package:kujitoon/feature/follow/bloc/follow_comic_state.dart';
import 'package:kujitoon/feature/follow/domain/entities/detail_commic_entity.dart';

abstract class FollowComicEvent {}

class FeatchFollowComicByPageEvent extends FollowComicEvent {
  final int page;
  final int pageSize = 5;
  FeatchFollowComicByPageEvent(this.page);
}

class NextPageFollowComicEvent extends FollowComicEvent {
  final int page;
  NextPageFollowComicEvent(this.page);
}

class IncreaseViewEvent extends FollowComicEvent {
  final DetailCommicEntity detailCommicEntity;
  final LoadedFollowComicState oldLoadedFollowComicState;
  IncreaseViewEvent(this.detailCommicEntity, {required this.oldLoadedFollowComicState});
}

class UpdateChapterReadEvent implements FollowComicEvent{
  final String slug;
  final String chapter;
  final int indexChapter;

  UpdateChapterReadEvent({required this.chapter, required this.slug, required this.indexChapter});
}

class RemoveFollowComicEvent extends FollowComicEvent {
  final String slug;

  RemoveFollowComicEvent(this.slug);
}