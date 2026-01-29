import 'package:kujitoon/feature/auth/data/datasources/auth_remote_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository{
  final AuthRemoteDatasource remote;

  AuthRepositoryImpl({required this.remote});

  @override
  Future<User?> login(String email, String password) async {
    return await remote.login(email, password);
  }

  @override
  Future<void> logout() {
    return remote.logout();
  }

}