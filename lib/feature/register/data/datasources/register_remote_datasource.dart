import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterRemoteDatasource {
  final FirebaseAuth auth;

  RegisterRemoteDatasource({required this.auth});

  Future<User?> register(String email, String password, String userName) async {
    final credential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    final user = credential.user;
    if(user != null){
      createUserProfile(user, userName);
    }
    return user;
  }

  Future<void> createUserProfile(User user, String userName) async {
    await FirebaseFirestore.instance
        .collection("data")
        .doc("users")
        .collection("profile")
        .doc(user.uid)
        .set({
      "email": user.email,
      "created_at": DateTime.now().millisecondsSinceEpoch,
      "name": userName,
      "avatar": "",
    });
  }

}