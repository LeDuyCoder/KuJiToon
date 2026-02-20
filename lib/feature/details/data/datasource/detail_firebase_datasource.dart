import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailFirebaseDatasource {
  Future<void> updateChapter(String slug, String chapter) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection("data")
        .doc("users")
        .collection("commic")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(slug)
        .doc(chapter).set({});
  }

  Future<void> inscreaseView(String slug, int amountCurrentView) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('data')
        .doc('commics')
        .collection(slug)
        .doc("statistics").set({"amount": ++amountCurrentView});
  }
}