import 'package:flutter/material.dart';

class SearchRouteInput {
  final String key;
  final String page;

  SearchRouteInput({required this.key, required this.page});

  factory SearchRouteInput.fromUri(Uri uri) {
    final params = uri.queryParameters;

    final keyword = params['keyword'];
    final page = params['page'];

    if (keyword == null || keyword.isEmpty || page == null || page.isEmpty) {
      throw ArgumentError('Missing required query param: keyword, page');
    }

    return SearchRouteInput(key: keyword, page: page);
  }


}