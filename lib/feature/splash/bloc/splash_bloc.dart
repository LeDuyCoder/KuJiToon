import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState>{
  SplashBloc() : super(SplashInitial()){
    on<AppStarted>(_onAppStarted);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<SplashState> emit) async {
    emit(SplashLoading());

    await Future.delayed(Duration(seconds: 3));
    //handle loading

    bool isLoggedIn = true;

    if(isLoggedIn){
      emit(SplashSuccess());
    }else{
      emit(SplashFailure());
    }
  }
}