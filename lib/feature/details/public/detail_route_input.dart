import 'package:kujitoon/feature/details/public/detail_user_route_params.dart';

class DetailRouteInput {
  static const _path = '/detail';

  final String slug;
  final DetailUserRouteParams userParams;

  const DetailRouteInput({
    required this.slug,
    required this.userParams,
  });

  /// Build URI để push (KHÔNG dùng domain entity)
  Uri toUri() {
    return Uri(
      path: _path,
      queryParameters: {
        'slug': slug,
        ...userParams.toQueryParams(), // ✅ DTO thuần
      },
    );
  }

  /// Parse từ URI khi nhận ở feature detail
  factory DetailRouteInput.fromUri(Uri uri) {
    final params = uri.queryParameters;

    return DetailRouteInput(
      slug: params['slug']!,
      userParams: DetailUserRouteParams.fromQueryParams(params),
    );
  }
}