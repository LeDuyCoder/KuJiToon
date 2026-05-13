import 'package:kujitoon/feature/follow/domain/entities/detail_commic_entity.dart';

abstract class FollowComicRepository {
  Future<List<DetailCommicEntity>> getAllFollowCommic();
  Future<List<DetailCommicEntity>> getFollowComicByPageSize(int page, int size);
  Future<int> getTotalFollowComic();

  Future<void> updateReadingProgress(String slug, String chapter, int indexChapter);
  Future<void> updateView(String slug, int amountCurrentView);
  Future<void> removeFollowComic(String slug);
}