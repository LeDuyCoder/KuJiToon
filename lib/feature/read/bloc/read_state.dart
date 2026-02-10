import 'package:kujitoon/feature/read/domain/entities/chapter_infomation_entity.dart';

abstract class ReadState {}

class LoaingReadState extends ReadState{}

class LoadedReadState extends ReadState{
  final ChapterInfomationEntity chapterInfomationEntity;

  LoadedReadState({required this.chapterInfomationEntity});
}

class ErrorReadState extends ReadState{
  final String msg;

  ErrorReadState({required this.msg});
}