import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:kujitoon/core/user/app_user.dart';

class UserProvider extends ChangeNotifier {
  AppUser? _user;
  bool _loaded = false;

  AppUser? get user => _user;
  bool get isLoaded => _loaded;

  Future<void> loadUser(String uid) async {
    if (_loaded) return;

    final doc = await FirebaseFirestore.instance
        .collection('data')
        .doc("users")
        .collection('profile')
        .doc(uid)
        .get();

    if (doc.exists) {
      _user = AppUser.fromFirestore(doc.data()!, uid);
    }

    _loaded = true;
    notifyListeners();
  }

  void clear() {
    _user = null;
    _loaded = false;
    notifyListeners();
  }
}