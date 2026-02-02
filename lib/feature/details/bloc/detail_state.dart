import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';

abstract class DetailState{}

class LoadingDetailState implements DetailState{}

class LoadedDetailState implements DetailState{
  final DetailCommicEntity detailCommicEntity;

  LoadedDetailState({required this.detailCommicEntity});
}

class NoDataDetailState implements DetailState{}

class ErrorDetailState implements DetailState{
  final String msg;

  ErrorDetailState({required this.msg});
}