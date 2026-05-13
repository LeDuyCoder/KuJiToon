import 'package:kujitoon/feature/follow/domain/repositories/follow_comic_repository.dart';

class FollowComicUsecase {
  final FollowComicRepository repository;

  FollowComicUsecase({required this.repository});

  Future<void> updateChapterRead(String slug, String chapter, int indexChapter){
    return repository.updateReadingProgress(slug, chapter, indexChapter);
  }

  Future<void> inscreaseView(String slug, int amountCurrentView) async {
    repository.updateView(slug, amountCurrentView);
  }

  Future<void> removeFollowComic(String slug) async {
    return repository.removeFollowComic(slug);
  }

}