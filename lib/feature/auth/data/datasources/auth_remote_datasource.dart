import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDatasource {
  final FirebaseAuth auth;

  AuthRemoteDatasource(this.auth);

  Future<User?> login(String email, String password) async {
    print(email);
    print(password);
    final credential = await auth.signInWithEmailAndPassword(email: email, password: password);
    final user = credential.user;
    return user;
  }

  Future<void> logout() async{
    await auth.signOut();
  }
}