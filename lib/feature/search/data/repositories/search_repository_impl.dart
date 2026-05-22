import 'package:kujitoon/feature/search/data/datasource/search_remote_datasource.dart';
import 'package:kujitoon/feature/search/domain/entities/prominent_commic.dart';
import 'package:kujitoon/feature/search/domain/entities/result_search.dart';
import 'package:kujitoon/feature/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository{
  @override
  Future<ResultSearch> search(String keyword, {int page = 1}) {
    SearchRemoteDatasource searchRemoteDatasource = SearchRemoteDatasource();
      return searchRemoteDatasource.search(keyword, page: page);
  }

}