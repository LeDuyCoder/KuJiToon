import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';

abstract class DetailRepository {
  Future<DetailCommicEntity?> featchData(String slug);

  /// Save reading progress (local + remote)
  Future<void> updateReadingProgress(String slug, String chapter, int indexChapter);

  Future<void> updateView(String slug, int amountCurrentView);
}