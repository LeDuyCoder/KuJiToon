import 'package:flutter/foundation.dart';

class LastChapterDto {
  final String _name;
  final String _chapterTitle;
  final String _fileName;
  final String _chapterApiData;

  LastChapterDto({
    required String name,
    required String chapterTitle,
    required String fileName,
    required String chapterApiData,
  })  : _name = name,
        _chapterTitle = chapterTitle,
        _fileName = fileName,
        _chapterApiData = chapterApiData;

  String get chapterApiData => _chapterApiData;
  String get fileName => _fileName;
  String get chapterTitle => _chapterTitle;
  String get name => _name;

  Map<String, String> toJson() {
    return {
      'name': _name,
      'chapterTitle': _chapterTitle,
      'fileName': _fileName,
      'chapterApiData': _chapterApiData,
    };
  }
}