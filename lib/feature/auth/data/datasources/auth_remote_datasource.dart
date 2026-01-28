import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDatasource {
  Future<User?> login(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final credential = await auth.signInWithEmailAndPassword(email: email, password: password);
    final user = credential.user;
    return user;
  }

  Future<void> logout() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
  }
}