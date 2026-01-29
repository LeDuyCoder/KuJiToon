import 'package:flutter/foundation.dart';

class LatestChapterCommic {
  final String _name;
  final String _chapterTitle;
  final String _fileName;
  final String _chapterApiData;

  LatestChapterCommic({
    required String name,
    required String chapterTitle,
    required String fileName,
    required String chapterApiData,
  })  : _name = name,
        _chapterTitle = chapterTitle,
        _fileName = fileName,
        _chapterApiData = chapterApiData;

  String get name => _name;
  String get chapterTitle => _chapterTitle;
  String get fileName => _fileName;
  String get chapterApiData => _chapterApiData;

  LatestChapterCommic fromJson(Map<String, dynamic> json) {
    return LatestChapterCommic(
      name: json['name'] as String,
      chapterTitle: json['chapterTitle'] as String,
      fileName: json['fileName'] as String,
      chapterApiData: json['chapterApiData'] as String,
    );
  }
}