import 'package:firebase_auth/firebase_auth.dart';
import 'package:kujitoon/feature/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase({required this.repository});

  Future<User?> call(String email, String password){
    return repository.login(email, password);
  }
}