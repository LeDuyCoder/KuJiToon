part of 'auth_bloc.dart';

abstract class AuthState extends Equatable{
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthSucessed extends AuthState{
  final User user;

  const AuthSucessed(this.user);
}

class AuthHandling extends AuthState{}

class AuthInitial extends AuthState{}

class AuthFailed extends AuthState{
  final String msg;

  const AuthFailed(this.msg);

  @override
  List<Object?> get props => [];
}