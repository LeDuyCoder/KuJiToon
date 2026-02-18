import 'dart:convert';

import 'package:kujitoon/core/model/chapter_dto.dart';
import 'package:kujitoon/core/service/base_service.dart';
import 'package:http/http.dart' as http;

class ChapterService implements BaseService<ChapterDto?, String> {

  List<String> hanldListImage(List<dynamic> data){
    List<String> listChapterImage = [];
    for(var chapter in data){
      listChapterImage.add(chapter["image_file"]);
    }
    
    return listChapterImage;
  }

  @override
  Future<ChapterDto?> call(String urlChapter) async {
    final uri = Uri.parse(urlChapter);
    ChapterDto? chapterDto;

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      chapterDto = ChapterDto(
          domainCDN: body["data"]["domain_cdn"],
          chapterPath: body["data"]["item"]["chapter_path"],
          listChapterImages: hanldListImage(body["data"]["item"]["chapter_image"]),
          chapterName: body["data"]["item"]["chapter_name"]
      );
    }

    return chapterDto;
  }

}