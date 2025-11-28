import 'package:kujitoon/feature/auth/domain/entities/user_entity.dart';
import 'package:kujitoon/feature/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase({required this.repository});

  Future<UserEntity?> call(String email, String password){
    return repository.login(email, password);
  }
}