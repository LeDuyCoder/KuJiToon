import 'package:kujitoon/feature/home/domain/entities/data_entity.dart';

abstract class HomeState {}

class LoadingHomeState extends HomeState {}

class LoadedHomeState extends HomeState {
  final DataEntity dataEntity;
  LoadedHomeState({required this.dataEntity});
}

class ErrorHomeState extends HomeState {
  final String message;
  ErrorHomeState({required this.message});
}
