import 'package:kujitoon/core/model/all_commic_dto.dart';
import 'package:kujitoon/core/service/base_service.dart';

import 'dart:convert';
import 'dart:developer';

import 'package:kujitoon/core/model/last_chapter_dto.dart';
import 'package:kujitoon/core/model/prominent_commic_dto.dart';
import 'package:http/http.dart' as http;

class AllCommicService extends BaseService<AllCommicDto?, int>{
  final String URL = 'https://otruyenapi.com/v1/api/danh-sach/truyen-moi?page=';

  @override
  Future<AllCommicDto?> call(int page) async {
    final uri = Uri.parse(URL + page.toString());

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      List<ProminentCommicDto> prominentCommics = [];
      for (var item in body['data']['items']) {
        if(item['chaptersLatest'] != null) {
          prominentCommics.add(
            ProminentCommicDto(
              slug: item['slug'],
              urlImage: item['thumb_url'],
              title: item['name'],
              updatedAt: DateTime.parse(item['updatedAt']),
              chapterCount: int.tryParse(item['chaptersLatest'][0]["chapter_name"]?.toString() ?? '') ?? 0,
              lastChapters: (item['chaptersLatest'] as List<dynamic>).map((chapter) {
                return LastChapterDto(
                  name: chapter['chapter_name'] ?? '',
                  chapterTitle: chapter['chapter_title'] ?? '',
                  fileName: chapter['filename'] ?? '',
                  chapterApiData: chapter['chapter_api_data'] ?? '',
                );
              }).toList(),
            ),
          );
        }
      }

      int totalItems = body['data']['params']['pagination']['totalItems'];
      int itemsPerPage = body['data']['params']['pagination']['totalItemsPerPage'];
      int currentPage = body['data']['params']['pagination']['currentPage'];

      int totalPages = (totalItems / itemsPerPage).ceil();


      return AllCommicDto(
        listProminentCommics: prominentCommics,
        pageSize:  itemsPerPage,
        totalPages: totalPages,
        currentPage: currentPage
      );
    } else {
      log("CommicService Error Call API: ${response.statusCode}");
      return null;
    }
  }

}