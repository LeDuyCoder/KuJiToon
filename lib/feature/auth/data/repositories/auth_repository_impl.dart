import 'package:kujitoon/feature/auth/data/datasources/auth_remote_datasource.dart';
import 'package:kujitoon/feature/auth/domain/entities/user_entity.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository{
  final AuthRemoteDatasource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<UserEntity?> login(String email, String password) async {
    return await remote.login(email, password);
  }

  @override
  Future<void> logout() {
    return remote.logout();
  }

}