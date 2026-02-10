import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/feature/shared_header/bloc/header_event.dart';
import 'package:kujitoon/feature/shared_header/bloc/header_state.dart';
import 'package:kujitoon/feature/shared_header/domain/entities/user_entity.dart';
import 'package:kujitoon/feature/shared_header/domain/usecase/header_usecase.dart';

class HeaderBloc extends Bloc<HeaderEvent, HeaderState>{
  final HeaderUsecase headerUsecase;

  HeaderBloc({required this.headerUsecase}) : super(LoadingHeaderState()){
    on<LoadDataEvent>(_onLogin);
  }

  Future<void> _onLogin(LoadDataEvent event, Emitter<HeaderState> emit) async {
    emit(LoadingHeaderState());

    try{
      UserEntity userEntity = await headerUsecase.loadUser();
      emit(LoadedHeaderState(userEntity: userEntity));
    }catch(e){
      emit(ErrorHeaderState(msg: "Error Loaded"));
    }

  }
}