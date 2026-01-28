import 'dart:convert';
import 'dart:developer';

import 'package:kujitoon/core/enum/status_enum.dart';
import 'package:kujitoon/core/model/commic_dto.dart';
import 'package:kujitoon/core/service/base_service.dart';
import 'package:http/http.dart' as http;

class CommicService implements BaseService<CommicDTO?, String> {
  final String URL = 'https://otruyenapi.com/v1/api/truyen-tranh/';

  List<String> hanldeTags(List<dynamic> tags) {
    List<String> tagList = [];
    for (var tag in tags) {
      tagList.add(tag['name']);
    }
    
    return tagList;
  }
  
  @override
  Future<CommicDTO?> call(String slug) async {
    final uri = Uri.parse(URL + slug);

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return  CommicDTO(
          slug: slug,
          title: body['data']['item']['name'],
          description: body['data']['item']['content'],
          imageUrl: body['data']['item']['thumb_url'],
          tags: hanldeTags(body['data']['item']['category']),
          status: StatusEnumExt.fromValue(body['data']['item']['status']),
          createdAt: DateTime.parse(body['data']['item']['updatedAt'])
      );

    } else {
      log("CommicService Error Call API: ${response.statusCode}");
      return null;
    }
  }
}