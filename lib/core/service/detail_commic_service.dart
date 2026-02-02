import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kujitoon/core/enum/status_enum.dart';
import 'package:kujitoon/core/model/detail_commic_dto.dart';
import 'package:kujitoon/core/model/last_chapter_dto.dart';
import 'package:kujitoon/core/model/tag_dto.dart';
import 'package:kujitoon/core/service/base_service.dart';
import 'package:http/http.dart' as http;

class DetailCommicService implements BaseService<DetailCommicDto?, String>{

  Future<List<String>> getAllChapterRead(String userId, String slug) async {
    final doc = await FirebaseFirestore.instance
        .collection('data')
        .doc('users')
        .collection('commic')
        .doc(userId)
        .collection(slug)
        .get();

    List<String> listChapterRead = [];
    listChapterRead.addAll(
        doc.docs.map((chapter){
          return chapter.id;
        }).toList()
    );

    return listChapterRead;
  }

  Future<int> getCountRead(String slug) async {
    final doc = await FirebaseFirestore.instance
        .collection('data')
        .doc('commics')
        .collection(slug)
        .doc("statistics")
        .get();

    int countRead = 0;

    if(doc.exists){
      countRead = doc.data()!["amount"];
    }

    return countRead;
  }

  @override
  Future<DetailCommicDto?> call(String slug) async {
    final String URL = 'https://otruyenapi.com/v1/api/truyen-tranh/';

    final uri = Uri.parse(URL + slug);

    List<String> listChapter = await getAllChapterRead(FirebaseAuth.instance.currentUser!.uid, slug);

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return DetailCommicDto(
          slug: slug,
          title: body["data"]["item"]["name"],
          description: body["data"]["item"]["content"],
          status: StatusEnumExt.fromValue(body["data"]["item"]["status"]),
          urlImage: body["data"]["item"]["thumb_url"],
          chapters: (body["data"]["item"]["chapters"][0]["server_data"] as List<dynamic>).map((chapter){
            return LastChapterDto(
                name: chapter["chapter_name"],
                chapterTitle: chapter["chapter_title"],
                fileName: chapter["filename"],
                chapterApiData: chapter["chapter_api_data"],
                isRead: listChapter.contains(chapter["chapter_name"])
            );
          }).toList(),
          updateAt: DateTime.parse(body["data"]["item"]["updatedAt"]),
          tags: (body["data"]["item"]["category"] as List<dynamic>).map((category){
            return TagDto(
                id: category["id"],
                name: category["name"],
                slug: category["slug"]
            );
          }).toList(),
          countRead: await getCountRead(slug)
      );
    } else {
      log("DetailCommicService Error Call API: ${response.statusCode}");
      return null;
    }

  }

}