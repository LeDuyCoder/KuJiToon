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
    final decoded = QueryCryptoUtil.decode(params['u']!);

    return UserEntity(
      name: decoded['name'],
      email: decoded['email'],
      admin: decoded['admin'],
      avatar: decoded['avatar'],
      createdAt: DateTime.parse(decoded['createdAt']),
    );
  }
}