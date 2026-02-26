import 'package:flutter/material.dart';

class ReadRouteInput {
  final String slug;

  const ReadRouteInput({
    required this.slug,
  });

  factory ReadRouteInput.fromUri(Uri uri) {
    final params = uri.queryParameters;

    final slug = params['slug'];
    if (slug == null || slug.isEmpty) {
      throw ArgumentError('Missing required query param: slug');
    }

    return ReadRouteInput(slug: slug);
  }
}