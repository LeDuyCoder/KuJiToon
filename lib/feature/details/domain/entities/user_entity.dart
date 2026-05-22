import 'package:kujitoon/core/utils/query_crypto_util.dart';

class UserEntity {
  final String name;
  final String email;
  final bool admin;
  final String avatar;
  final DateTime createdAt;

  UserEntity({
    required this.name,
    required this.email,
    required this.admin,
    required this.avatar,
    required this.createdAt,
  });

  /// Convert -> query string params
  Map<String, String> toQueryParams() {
    return {
      'u': QueryCryptoUtil.encode({
        'name': name,
        'email': email,
        'admin': admin,
        'avatar': avatar,
        'createdAt': createdAt.toIso8601String(),
      }),
    };
  }

  /// Convert <- query string params
  factory UserEntity.fromQueryParams(Map<String, String> params) {
    final encoded = params['u'];

    if (encoded == null || encoded.isEmpty) {
      throw ArgumentError('Missing user query param "u"');
    }

    final decoded = QueryCryptoUtil.decode(encoded);

    return UserEntity(
      name: decoded['name'] ?? '',
      email: decoded['email'] ?? '',
      admin: decoded['admin'] == true || decoded['admin'] == 'true',
      avatar: decoded['avatar'] ?? '',
      createdAt: DateTime.tryParse(decoded['createdAt'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}