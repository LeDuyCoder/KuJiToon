
import 'package:kujitoon/feature/details/data/datasource/detail_firebase_datasource.dart';
import 'package:kujitoon/feature/details/data/datasource/detail_local_datasource.dart';
import 'package:kujitoon/feature/details/data/datasource/detail_remote_datasource.dart';
import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/domain/repositories/detail_repository.dart';

class DetailRepositoryImpl implements DetailRepository{
  final DetailRemoteDatasource remoteSource;
  final DetailFirebaseDatasource firebaseSource;
  final DetailLocalDatasource localSource;

  DetailRepositoryImpl({required this.remoteSource, required this.firebaseSource, required this.localSource});

  @override
  Future<DetailCommicEntity?> featchData(String slug) {
    return remoteSource.featchData(slug);
  }

  @override
  Future<void> updateReadingProgress(String slug, String chapter, int indexChapter) async {
    firebaseSource.updateChapter(slug, chapter);
    localSource.updateChapterReadLocalStorge(slug, chapter, indexChapter);
  }

  @override
  Future<void> updateView(String slug, int amountCurrentView) async {
    return firebaseSource.inscreaseView(slug, amountCurrentView);
  }
}