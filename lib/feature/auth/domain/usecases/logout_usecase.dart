import 'package:kujitoon/feature/auth/domain/repositories/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository repository;

  LogoutUsecase({required this.repository});

  Future<void> call(){
    return repository.logout();
  }
}