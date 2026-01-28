import 'package:kujitoon/feature/home/domain/entities/data_entity.dart';
import 'package:kujitoon/feature/home/domain/repositories/home_repositories.dart';

class FetchDataUsecase {
  final HomeRepository repository;

  FetchDataUsecase({required this.repository});

  Future fetchData() {
    return repository.fetchData();
  }

  Future changePage(DataEntity oldDataEntity, int page) {
    return repository.changePage(oldDataEntity, page);
  }
}