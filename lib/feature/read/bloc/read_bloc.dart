import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/feature/read/bloc/read_event.dart';
import 'package:kujitoon/feature/read/bloc/read_state.dart';
import 'package:kujitoon/feature/read/domain/entities/chapter_infomation_entity.dart';
import 'package:kujitoon/feature/read/domain/usecase/read_usecase.dart';

class ReadBloc extends Bloc<ReadEvent, ReadState> {
  final ReadUsecase readUsecase;

  ReadBloc({required this.readUsecase}) : super(LoaingReadState()) {
    on<FeatchDataReadEvent>(_onLoad);
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
}
