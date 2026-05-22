import 'package:kujitoon/core/service/search_service.dart';
import 'package:kujitoon/feature/search/domain/entities/category.dart';
import 'package:kujitoon/feature/search/domain/entities/prominent_commic.dart';
import 'package:kujitoon/feature/search/domain/entities/result_search.dart';

class SearchRemoteDatasource {
  Future<ResultSearch> search(String keyword, {int page = 1}) async {
    SearchService searchService = SearchService();
    Map<String, dynamic> data = await searchService.call(keyword, page: page);

    List<dynamic> prominentsData = data['data']["items"];

    List<ProminentCommic> prominentsCommic = prominentsData.map((commic) => ProminentCommic(
        name: commic['name'],
        slug: commic['slug'],
        originName: commic['origin_name'][0] ?? '',
        ongoing: commic['status'],
        thumbUrl: commic['thumb_url'],
        categories: (commic['category'] as List).map((categories) => Category(
            id: categories['id'],
            name: categories['name'],
            slug: categories['slug']
        )).toList()
    )).toList();

    int totalPage = data['data']['params']['pagination']['pageRanges'];
    int currentPage = page;
    int totalItem = data['data']['params']['pagination']['totalItems'];

    return ResultSearch(prominentComics: prominentsCommic, totalPage: totalPage, currentPage: currentPage, totalItem: totalItem);
  }
}