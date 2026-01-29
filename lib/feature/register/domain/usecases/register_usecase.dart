import 'package:kujitoon/feature/register/domain/repositories/register_reository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterUsecase {
  final RegisterReository repository;

  RegisterUsecase({required this.repository});

  Future<User?> call(String email, String password, String userName){
    return repository.register(email, password, userName);
  }
}