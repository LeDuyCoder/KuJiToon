import 'package:kujitoon/feature/home/domain/entities/data_entity.dart';

abstract class HomeEvent {}

class FetchHomeDataEvent extends HomeEvent {}

class ChangePageHomeDataEvent extends HomeEvent {
  final DataEntity oldDataEntity;
  final int page;

  ChangePageHomeDataEvent({required this.page, required this.oldDataEntity});
}