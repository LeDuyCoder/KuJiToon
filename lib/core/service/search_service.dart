import 'dart:convert';

import 'package:kujitoon/core/service/base_service.dart';

import 'package:http/http.dart' as http;

class SearchService implements BaseService<Map<String, dynamic>, String>{
  final String URL = 'otruyenapi.com';

  @override
  Future<Map<String, dynamic>> call(params, {int page = 1}) async {
    final uri = Uri(
      scheme: "https",
      host: URL,
      path: "/v1/api/tim-kiem",
      queryParameters: {
        'keyword': params,
        'page': page.toString()
      }
    );

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return {};
    }
  }

}