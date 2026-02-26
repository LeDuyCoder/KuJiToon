import 'package:kujitoon/feature/details/domain/entities/user_entity.dart';

class DetailUserRouteParams {
  final Map<String, String> params;

  DetailUserRouteParams({required this.params});

  factory DetailUserRouteParams.fromUserEntity(UserEntity user) {
    return DetailUserRouteParams(
      params: user.toQueryParams(),
    );
  }

  factory DetailUserRouteParams.fromQueryParams(Map<String, String> queryParams) {
    return DetailUserRouteParams(
      params: Map<String, String>.from(queryParams),
    );
  }

  Map<String, String> toQueryParams() => params;

  UserEntity toUserEntity() {
    return UserEntity.fromQueryParams(params);
  }
}