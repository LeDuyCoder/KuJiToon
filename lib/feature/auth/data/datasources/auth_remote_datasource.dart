import 'package:firebase_auth/firebase_auth.dart';
import 'package:kujitoon/feature/auth/data/models/UserModel.dart';

class AuthRemoteDatasource {
  final FirebaseAuth auth;

  AuthRemoteDatasource(this.auth);

  Future<UserModel?> login(String email, String password) async {
    final credential = await auth.signInWithEmailAndPassword(email: email, password: password);
    final user = credential.user;
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }

  Future<void> logout() async{
    await auth.signOut();
  }
}