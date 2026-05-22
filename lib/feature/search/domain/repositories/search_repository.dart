import 'package:kujitoon/feature/search/domain/entities/result_search.dart';

abstract class SearchRepository {
  Future<ResultSearch> search(String keyword, {int page = 1});
}