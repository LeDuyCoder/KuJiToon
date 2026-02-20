import 'dart:convert';

import 'package:kujitoon/core/utils/number_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailLocalDatasource {
  Future<bool> hasReadCommic(String slug) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.containsKey(slug);
  }

  Future<void> updateChapterReadLocalStorge(String slug, String chapter, int indexChapter) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    if(await hasReadCommic(slug)){
      String chapterStorage = jsonDecode(storage.getString(slug)??"")["chapter"];
      if(NumberParser.toDouble(chapterStorage) < NumberParser.toDouble(chapter)){
        storage.setString(slug, jsonEncode({"chapter": chapter, "index": indexChapter}));
      }
    }else{
      storage.setString(slug, jsonEncode({"chapter": chapter, "index": indexChapter}));
    }
  }
}