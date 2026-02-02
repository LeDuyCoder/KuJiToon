import 'dart:convert';
import 'dart:developer';
import 'package:kujitoon/core/model/last_chapter_dto.dart';
import 'package:kujitoon/core/model/prominent_commic_dto.dart';
import 'package:kujitoon/core/service/base_service.dart';
import 'package:http/http.dart' as http;

class ProminentCommicService extends BaseService<List<ProminentCommicDto>, Null>{
  final String URL = 'https://otruyenapi.com/v1/api/home';

  @override
  Future<List<ProminentCommicDto>> call(Null params) async {
    final uri = Uri.parse(URL);

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
        if(item['chaptersLatest'] != null && prominentCommics.length < 15) {
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
                  isRead: false,
                );
              }).toList(),
            ),
          );
        }
      }
      return prominentCommics;
    } else {
      log("CommicService Error Call API: ${response.statusCode}");
      return [];
    }
  }

}