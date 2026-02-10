import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kujitoon/feature/auth/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase({required this.repository});

  Future<User?> call(String email, String password){
    return repository.login(email, password);
  }

  Future<void> setSessionLogin(String userId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final doc = await FirebaseFirestore.instance
        .collection('data')
        .doc('users')
        .collection('profile')
        .doc(userId)
        .get();

    var data = doc.data();

    if(data != null){
      sharedPreferences.setString("user", jsonEncode(data));
    }
  }
}