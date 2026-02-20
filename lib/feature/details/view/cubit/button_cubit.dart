import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/domain/entities/last_chapter_entity.dart';
import 'package:kujitoon/feature/details/view/cubit/button_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonCubit extends Cubit<ButtonState> {
  ButtonCubit() : super(StartReadButtonState());

  Future<void> checkReadStatus(String slug) async {
    try {

      final storage = await SharedPreferences.getInstance();
      int indextChapter = storage.containsKey(slug) ?  jsonDecode(storage.getString(slug)??"")["index"] : 0;
      if (!storage.containsKey(slug)) {
        emit(StartReadButtonState());
        return;
      }

      emit(ContinuteButtonState(indexChapter: indextChapter));
    } catch (e) {
      emit(StartReadButtonState());
    }
  }

  Future<void> readComic(
     BuildContext context,
    List<LastChapterEntity> chapterEntities,
    DetailCommicEntity detailCommicEntity,
  ) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    Map<String, dynamic>? dataChapter = storage.containsKey(detailCommicEntity.slug)
        ? jsonDecode(storage.getString(detailCommicEntity.slug) ?? "")
        : null;
    int index = 0;
    if(dataChapter != null){
      index = dataChapter["index"];
    }

    emit(ContinuteButtonState(indexChapter: index));

    Navigator.pushNamed(
      context,
      '/read',
      arguments: {
        'chapters': chapterEntities, // List<ChapterEntity>
        'urlChapter': chapterEntities.elementAt(index).chapterApiData, // String
        'detailComicEntity': detailCommicEntity,
        'currentIndexChapter': index
      },
    );
  }
}
