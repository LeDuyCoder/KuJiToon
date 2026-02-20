import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/domain/repositories/detail_repository.dart';

class DetailCommicUsecase {
  final DetailRepository repository;

  DetailCommicUsecase({required this.repository});

  Future<DetailCommicEntity?> fetchData(String slug) {
    return repository.featchData(slug);
  }

  Future<void> updateChapterRead(String slug, String chapter, int indexChapter){
    return repository.updateReadingProgress(slug, chapter, indexChapter);
  }


  Future<void> inscreaseView(String slug, int amountCurrentView) async {
    repository.updateView(slug, amountCurrentView);
  }
}