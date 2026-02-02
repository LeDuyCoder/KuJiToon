import 'package:kujitoon/feature/details/data/datasource/detail_datasource.dart';
import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/domain/repositories/detail_repository.dart';

class DetailRepositoryImpl implements DetailRepository{
  final DetailDatasource source;

  DetailRepositoryImpl({required this.source});

  @override
  Future<DetailCommicEntity?> featchData(String slug) {
    return source.featchData(slug);
  }

}