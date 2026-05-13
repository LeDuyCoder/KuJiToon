import 'package:kujitoon/feature/follow/domain/entities/detail_commic_entity.dart';

abstract class FollowComicState {}

class LoadingFollowComicState extends FollowComicState {}

class LoadedFollowComicState extends FollowComicState {
  final List<DetailCommicEntity> listFollowedComics;
  final int totalComics;

  LoadedFollowComicState({required this.listFollowedComics, required this.totalComics});
}

class EmptyFollowComicState extends FollowComicState {}

class ErrorFollowComicState extends FollowComicState {
  final String message;

  ErrorFollowComicState({required this.message});
}