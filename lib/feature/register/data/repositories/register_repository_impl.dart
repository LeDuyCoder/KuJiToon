import 'package:firebase_auth/firebase_auth.dart';
import 'package:kujitoon/feature/register/data/datasources/register_remote_datasource.dart';
import 'package:kujitoon/feature/register/domain/repositories/register_reository.dart';

class RegisterRepositoryImpl extends RegisterReository{
  final RegisterRemoteDatasource remote;

  RegisterRepositoryImpl({required this.remote});

  @override
  Future<User?> register(String email, String password, String userName) {
    return remote.register(email, password, userName);
  }
}