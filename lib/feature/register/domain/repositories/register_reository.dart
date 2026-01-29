import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterReository {
  Future<User?> register(String email, String password, String userName);
}