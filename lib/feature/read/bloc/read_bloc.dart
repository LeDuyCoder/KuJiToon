import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/domain/entities/last_chapter_entity.dart';
import 'package:kujitoon/feature/read/bloc/read_event.dart';
import 'package:kujitoon/feature/read/bloc/read_state.dart';
import 'package:kujitoon/feature/read/domain/entities/chapter_infomation_entity.dart';
import 'package:kujitoon/feature/read/domain/usecase/read_usecase.dart';
import 'dart:html' as html;

class ReadBloc extends Bloc<ReadEvent, ReadState> {
  final ReadUsecase readUsecase;

  ReadBloc({required this.readUsecase}) : super(LoaingReadState()) {
    on<FeatchDataReadEvent>(_onLoad);
    on<FeatchDataReadWebsiteEvent>(_onLoadWebsite);
  }

  Future<void> _onLoad(FeatchDataReadEvent event, Emitter emit) async {
    emit(LoaingReadState());
    try {
      ChapterInfomationEntity? chapter = await readUsecase.featchData(
        event.detailComicEntity,
        event.listChapters,
        event.urlChapter,
        event.currentIndex
      );
      if (chapter == null) {
        emit(ErrorReadState(msg: "No Data"));
      } else {
        emit(LoadedReadState(chapterInfomationEntity: chapter));
      }
    } catch (e) {
      emit(ErrorReadState(msg: e.toString()));
    }
  }

  Future<void> _onLoadWebsite(FeatchDataReadWebsiteEvent event, Emitter emit) async {
    emit(LoaingReadState());
    try{
      Map<String, dynamic> data = jsonDecode(html.window.sessionStorage[event.keyPageLoad]??"");
      final DetailCommicEntity detailCommicEntity = DetailCommicEntity.fromJson(data["detailCommicEntity"]);
      final listChapters = (data['chapters'] as List)
          .map((e) => LastChapterEntity.fromJson(e))
          .toList();
      final String urlChapter = data["urlChapter"];
      final int currentIndex = data["currentIndex"];
      ChapterInfomationEntity? chapter = await readUsecase.featchData(
          detailCommicEntity,
          listChapters,
          urlChapter,
          currentIndex
      );
      if (chapter == null) {
        emit(ErrorReadState(msg: "No Data"));
      } else {
        emit(LoadedReadState(chapterInfomationEntity: chapter));
      }
    }catch(e) {
      emit(ErrorReadState(msg: e.toString()));
    }
  }
}
