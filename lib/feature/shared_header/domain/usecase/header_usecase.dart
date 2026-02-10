import 'package:kujitoon/feature/shared_header/domain/entities/user_entity.dart';
import 'package:kujitoon/feature/shared_header/domain/repositories/header_repository.dart';

class HeaderUsecase {
  final HeaderRepository repository;

  HeaderUsecase({required this.repository});

  Future<UserEntity> loadUser() async {
    return repository.loadUserEntity();
  }
}