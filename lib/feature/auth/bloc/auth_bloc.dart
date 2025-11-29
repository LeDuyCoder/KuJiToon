import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:kujitoon/feature/auth/domain/usecases/login_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final LoginUsecase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(AuthInitial()){
    on<LoginEvent>(_onLogin);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthHandling());

    try{
      final user = await loginUseCase.call(event.email, event.password);
      print(user);
      if(user != null){
        print("debug");
        emit(AuthSucessed());
      }else{
        emit(AuthFailed("email hoặc mật khẩu không đúng"));
      }
    }catch(e){
      emit(AuthFailed("email hoặc mật khẩu không đúng"));
      debugPrint("Auth error: $e");
    }

  }
}