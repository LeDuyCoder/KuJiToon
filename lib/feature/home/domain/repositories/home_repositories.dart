import 'package:kujitoon/feature/home/domain/entities/data_entity.dart';

abstract class HomeRepository {
  Future<DataEntity> fetchData();
  Future<DataEntity> changePage(DataEntity oldDataEntity ,int page);
}