import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/feature/register/domain/usecases/register_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  final RegisterUsecase registerUsecase;

  RegisterBloc({required this.registerUsecase}) : super(RegisterInitial()){
    on<RegisterEvent>(_onRegister);
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterHandling());

    try{
      final user = await registerUsecase.call(event.email, event.password, event.userName);
      if(user != null){
        emit(RegisterSucessed());
      }else{
        emit(RegisterFailed("email hoặc mật khẩu không đúng"));
      }
    }catch(e){
      emit(RegisterFailed("email hoặc mật khẩu không đúng"));
      debugPrint("Auth error: $e");
    }

  }
}