import 'package:kujitoon/feature/shared_header/domain/entities/user_entity.dart';

abstract class HeaderRepository {
  Future<UserEntity> loadUserEntity();
}