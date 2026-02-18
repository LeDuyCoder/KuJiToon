import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kujitoon/core/enum/status_enum.dart';
import 'package:kujitoon/core/model/all_commic_dto.dart';
import 'package:kujitoon/core/model/last_chapter_dto.dart';
import 'package:kujitoon/core/model/prominent_commic_dto.dart';
import 'package:kujitoon/core/service/all_commic_service.dart';
import 'package:kujitoon/core/service/prominent_commic_service.dart';
import 'package:kujitoon/feature/home/domain/entities/data_entity.dart';
import 'package:kujitoon/feature/home/domain/entities/last_read_commic.dart';
import 'package:kujitoon/feature/home/domain/entities/last_update_commic.dart';
import 'package:kujitoon/feature/home/domain/entities/latest_chapter_commic.dart';
import 'package:kujitoon/feature/home/domain/entities/list_last_update_commic.dart';
import 'package:kujitoon/feature/home/domain/entities/list_prominent_commic.dart';

import 'package:kujitoon/feature/home/domain/entities/prominent_commic.dart';
import 'package:kujitoon/feature/home/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDatasource {

  Future<LastReadCommic?> featchLastReadCommic() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;

    final doc = await FirebaseFirestore.instance
        .collection('data')
        .doc('users')
        .collection('last_read_commic')
        .doc(uid)
        .get();

    if (!doc.exists || doc.data() == null) {
      return null;
    }

    String slug = doc.get('slug');

    return LastReadCommic(
      urlImage: doc.get('urlImage'),
      slug: slug,
      title: doc.get('title'),
      tags: List<String>.from(doc.get('tags')),
      historyChapterRead: doc.get('historyChapterRead'),
      lastChapter: doc.get('lastChapter'),
      status: StatusEnum.values.firstWhere((e) => e.toString() == 'StatusEnum.' + doc.get('status')),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(doc.get('updatedAt')),
    );
  }

  Future<List<ProminentCommic>> fetchProminentCommics() async {
    final service = ProminentCommicService();
    final dtoList = await service.call(null);

    return dtoList.map(mapProminentDtoToEntity).toList();
  }

  ProminentCommic mapProminentDtoToEntity(ProminentCommicDto dto) {
    return ProminentCommic(
      slug: dto.slug,
      urlImage: dto.urlImage,
      title: dto.title,
      updatedAt: dto.updatedAt,
      chapterCount: dto.chapterCount,
    );
  }

  Future<ListLastUpdateCommic> fetchLastUpdateCommics(int page) async {
    final service = AllCommicService();
    final dto = await service.call(page);

    final list = (dto?.listProminentCommics ?? [])
        .map(mapLastUpdateDtoToEntity)
        .toList();

    return ListLastUpdateCommic(
      listLastUpdateCommics: list,
      pageSize: dto?.pageSize ?? 0,
      totalPages: dto?.totalPages ?? 0,
      currentPage: dto?.currentPage ?? 1,
    );
  }

  LastUpdateCommic mapLastUpdateDtoToEntity(ProminentCommicDto dto) {
    return LastUpdateCommic(
      title: dto.title,
      slug: dto.slug,
      imageUrl: dto.urlImage,
      updateTime: dto.updatedAt,
      latestChapters: dto.lastChapters.map(mapLatestChapterDtoToEntity).toList(),
    );
  }

  LatestChapterCommic mapLatestChapterDtoToEntity(LastChapterDto dto) {
    //print("check dto: ${dto.name}, ${dto.chapterTitle}");
    return LatestChapterCommic(
      name: dto.name,
      chapterTitle: dto.chapterTitle,
      fileName: dto.fileName,
      chapterApiData: dto.chapterApiData,
    );
  }


  Future<UserEntity> loadUserEntity() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> dataUser = jsonDecode(sharedPreferences.getString("user")!);

    return UserEntity(
        name: dataUser["name"],
        email: dataUser["email"],
        admin: dataUser["admin"],
        avatar: dataUser["avatar"],
        created_at: DateTime.fromMillisecondsSinceEpoch(dataUser["created_at"], isUtc: true)
            .toLocal()
    );
  }



  // ===================== MAIN =====================
  Future<DataEntity> fetchData() async {
    final prominentCommics = await fetchProminentCommics();
    final lastUpdateCommic = await fetchLastUpdateCommics(1);
    final lastReadCommic = await featchLastReadCommic();
    final userEntity = await loadUserEntity();

    return DataEntity(
      lastReadCommic: lastReadCommic,
      listProminentCommic:
      ListProminentCommic(listProminentCommics: prominentCommics),
      listLastUpdateCommic: lastUpdateCommic,
      userEntity: userEntity,
    );
  }

  Future<DataEntity> changePage(DataEntity oldDataEntity ,int page) async {

    final lastUpdateCommic = await fetchLastUpdateCommics(page);

    DataEntity newDataEntity = DataEntity(
      lastReadCommic: oldDataEntity.lastReadCommic,
      listProminentCommic: oldDataEntity.listProminentCommic,
      listLastUpdateCommic: lastUpdateCommic,
      userEntity: oldDataEntity.userEntity,
    );

    return newDataEntity;
  }


}