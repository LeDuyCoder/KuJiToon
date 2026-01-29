import 'package:kujitoon/feature/home/data/datasource/home_datasource.dart';
import 'package:kujitoon/feature/home/domain/entities/data_entity.dart';
import 'package:kujitoon/feature/home/domain/repositories/home_repositories.dart';

class HomeRepositoriesImpl implements HomeRepository{
  final HomeDatasource datasource;

  HomeRepositoriesImpl({required this.datasource});

  @override
  Future<DataEntity> fetchData() {
    return datasource.fetchData();
  }

  @override
  Future<DataEntity> changePage(DataEntity oldDataEntity, int page) {
    return datasource.changePage(oldDataEntity, page);
  }

}