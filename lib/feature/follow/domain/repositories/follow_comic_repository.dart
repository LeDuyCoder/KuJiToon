import 'package:kujitoon/feature/follow/domain/entities/detail_commic_entity.dart';

abstract class FollowComicRepository {
  Future<void> deleteFollowCommic(String id);
  Future<List<DetailCommicEntity>> getAllFollowCommic();
  Future<List<DetailCommicEntity>> getFollowComicByPageSize(int page, int size);
  Future<int> getTotalFollowComic();
}