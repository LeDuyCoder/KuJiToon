import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';

abstract class DetailRepository {
  Future<DetailCommicEntity?> featchData(String slug);
}