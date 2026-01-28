import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/feature/home/bloc/home_event.dart';
import 'package:kujitoon/feature/home/bloc/home_state.dart';
import 'package:kujitoon/feature/home/domain/entities/data_entity.dart';
import 'package:kujitoon/feature/home/domain/usecase/fetch_data_usecase.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchDataUsecase fetchDataUsecase;


  HomeBloc({required this.fetchDataUsecase}) : super(LoadingHomeState()) {
    on<FetchHomeDataEvent>(_onLoad);
    on<ChangePageHomeDataEvent>(_onChangePage);
  }

  Future<void> _onLoad(FetchHomeDataEvent event, Emitter emit) async {
    try{
      DataEntity dataEntity = await fetchDataUsecase.fetchData();
      emit(LoadedHomeState(dataEntity: dataEntity));
    }on Exception catch (_, e){
      emit(ErrorHomeState(message: e.toString()));
    }
  }

  Future<void> _onChangePage(ChangePageHomeDataEvent event, Emitter emit) async {
    try{
      emit(LoadingHomeState());
      DataEntity dataEntity = await fetchDataUsecase.changePage(event.oldDataEntity, event.page);
      emit(LoadedHomeState(dataEntity: dataEntity));
    }on Exception catch (_, e){
      emit(ErrorHomeState(message: e.toString()));
    }
  }
}