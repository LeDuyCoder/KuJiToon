import 'package:kujitoon/feature/follow/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/follow/domain/repositories/follow_comic_repository.dart';

class GetFollowComicPageUsecase {
  final FollowComicRepository repository;

  GetFollowComicPageUsecase({required this.repository});

  Future<List<DetailCommicEntity>> call(int page, int size) async {
    return repository.getFollowComicByPageSize(page, size);
  }

  Future<int> getTotalFollowComic() async {
    return await repository.getTotalFollowComic();
  }
}