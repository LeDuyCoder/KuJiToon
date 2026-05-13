import 'package:kujitoon/feature/follow/data/datasource/follow_comic_local_datasource.dart';
import 'package:kujitoon/feature/follow/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/follow/data/datasource/follow_comic_firebase_datasource.dart';
import 'package:kujitoon/feature/follow/data/datasource/follow_comic_remote_datasource.dart';
import 'package:kujitoon/feature/follow/domain/repositories/follow_comic_repository.dart';

class FollowComicRepositoryImpl implements FollowComicRepository{
  final FollowComicFirebaseDatasource followComicFirebaseDatasource;
  final FollowComicRemoteDatasource followComicRemoteDatasource;
  final FollowComicLocalDatasource followComicLocalDatasource;

  FollowComicRepositoryImpl({required this.followComicFirebaseDatasource, required this.followComicRemoteDatasource, required this.followComicLocalDatasource});


  @override
  Future<List<DetailCommicEntity>> getAllFollowCommic() {
    // TODO: implement getAllFollowCommic
    throw UnimplementedError();
  }

  @override
  Future<List<DetailCommicEntity>> getFollowComicByPageSize(int page, int size) async {
    List<String> slugs = await followComicFirebaseDatasource.getAllFollowComic();
    return followComicRemoteDatasource.getAllFollowComicByPageSize(slugs, size, page);
  }

  @override
  Future<int> getTotalFollowComic() async {
    List<String> slugs = await followComicFirebaseDatasource.getAllFollowComic();
    return slugs.length;
  }

  @override
  Future<void> updateReadingProgress(String slug, String chapter, int indexChapter) async {
    followComicFirebaseDatasource.updateChapter(slug, chapter);
    followComicLocalDatasource.updateChapterReadLocalStorge(slug, chapter, indexChapter);
  }

  @override
  Future<void> updateView(String slug, int amountCurrentView) async {
    return followComicFirebaseDatasource.inscreaseView(slug, amountCurrentView);
  }

  @override
  Future<void> removeFollowComic(String slug) async {
    return followComicFirebaseDatasource.removeFollowComic(slug);
  }

}