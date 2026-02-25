import 'package:kujitoon/feature/follow/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/follow/data/datasource/follow_comic_firebase_datasource.dart';
import 'package:kujitoon/feature/follow/data/datasource/follow_comic_remote_datasource.dart';
import 'package:kujitoon/feature/follow/domain/repositories/follow_comic_repository.dart';

class FollowComicRepositoryImpl implements FollowComicRepository{
  final FollowComicFirebaseDatasource followComicFirebaseDatasource;
  final FollowComicRemoteDatasource followComicRemoteDatasource;

  FollowComicRepositoryImpl({required this.followComicFirebaseDatasource, required this.followComicRemoteDatasource});

  @override
  Future<void> deleteFollowCommic(String id) {
    // TODO: implement deleteFollowCommic
    throw UnimplementedError();
  }

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

}