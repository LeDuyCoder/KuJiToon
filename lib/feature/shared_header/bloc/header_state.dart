import 'package:kujitoon/feature/shared_header/domain/entities/user_entity.dart';

abstract class HeaderState {}

class LoadingHeaderState extends HeaderState{}

class LoadedHeaderState extends HeaderState{
  final UserEntity userEntity;

  LoadedHeaderState({required this.userEntity});
}

class ErrorHeaderState extends HeaderState{
  final String msg;

  ErrorHeaderState({required this.msg});
}