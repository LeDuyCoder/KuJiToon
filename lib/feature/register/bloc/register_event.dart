part of 'register_bloc.dart';

abstract class absRegisterEvent extends Equatable {
  const absRegisterEvent();
}

class RegisterEvent extends absRegisterEvent{
  final String email;
  final String password;
  final String userName;

  RegisterEvent({required this.email, required this.password, required this.userName});

  @override
  List<Object?> get props => [];
}