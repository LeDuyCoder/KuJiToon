part of 'register_bloc.dart';

abstract class RegisterState extends Equatable{
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class RegisterSucessed extends RegisterState{}

class RegisterHandling extends RegisterState{}

class RegisterInitial extends RegisterState{}

class RegisterFailed extends RegisterState{
  final String msg;

  const RegisterFailed(this.msg);

  @override
  List<Object?> get props => [];
}