import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/feature/details/bloc/detail_event.dart';
import 'package:kujitoon/feature/details/bloc/detail_state.dart';
import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/domain/usecase/detail_commic_usecase.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState>{
  final DetailCommicUsecase detailCommicUsecase;

  DetailBloc({required this.detailCommicUsecase}) : super(LoadingDetailState()) {
    on<FetchDataDetailEvent>(_onLoad);
    on<UpdateChapterReadEvent>(_onUpdateChapterRead);
    on<IncreaseViewEvent>(_onIncreaseView);
  }

  Future<void> _onLoad(FetchDataDetailEvent event, Emitter emit) async {
    try{
      DetailCommicEntity? detailCommicEntity = await detailCommicUsecase.fetchData(event.slug);
      if(detailCommicEntity != null){
        emit(LoadedDetailState(detailCommicEntity: detailCommicEntity));
      }else{
        emit(NoDataDetailState());
      }
    }on Exception catch (_, e){
      emit(ErrorDetailState(msg: e.toString()));
    }
  }

  Future<void> _onUpdateChapterRead(UpdateChapterReadEvent event, Emitter emit) async {
    await detailCommicUsecase.updateChapterRead(event.slug, event.chapter, event.indexChapter);
  }

  Future<void> _onIncreaseView(IncreaseViewEvent event, Emitter emit) async {
    await detailCommicUsecase.inscreaseView(event.detailCommicEntity.slug, event.detailCommicEntity.countRead++);
    emit(LoadedDetailState(detailCommicEntity: event.detailCommicEntity));
  }
}