import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/view/cubit/follow_button_state.dart';

class FollowButtonCubit extends Cubit<FollowButtonState>{
  FollowButtonCubit() : super(UnFollowedButtonState());

  Future<void> checkFollow(String slug) async {

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String userId = FirebaseAuth.instance.currentUser!.uid;

    Map<String, dynamic>? data = (await firestore.collection("data")
              .doc("users")
              .collection("follows")
              .doc(userId)
              .collection("data")
              .doc(slug)
              .get()).data();

    if(data != null){
      emit(FollowingButtonState());
    } else {
      emit(UnFollowedButtonState());
    }
  }



  void followComic(DetailCommicEntity detailCommicEntity) async {

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await firestore.collection("data")
        .doc("users")
        .collection("follows")
        .doc(userId)
        .collection("data")
        .doc(detailCommicEntity.slug).set({
          "slug": detailCommicEntity.slug,
          "title": detailCommicEntity.title,
          "thumb": detailCommicEntity.urlImage,
        });

    emit(FollowingButtonState());
  }

  void unfollowComic(String slug) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await firestore.collection("data")
        .doc("users")
        .collection("follows")
        .doc(userId)
        .collection("data")
        .doc(slug).delete();

    emit(UnFollowedButtonState());
  }
}