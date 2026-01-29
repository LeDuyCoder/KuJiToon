import 'package:kujitoon/core/model/last_chapter_dto.dart';

class ProminentCommicDto {
  final String _slug;
  final String _urlImage;
  final String _title;
  final DateTime _updatedAt;
  final int _chapterCount;
  final List<LastChapterDto> _lastChapters;

  ProminentCommicDto({
    required String slug,
    required String urlImage,
    required String title,
    required DateTime updatedAt,
    required int chapterCount,
    required List<LastChapterDto> lastChapters,
  })  : _slug = slug,
        _urlImage = urlImage,
        _title = title,
        _updatedAt = updatedAt,
        _chapterCount = chapterCount,
        _lastChapters = lastChapters;

  List<LastChapterDto> get lastChapters => _lastChapters;

  int get chapterCount => _chapterCount;

  DateTime get updatedAt => _updatedAt;

  String get title => _title;

  String get urlImage => _urlImage;

  String get slug => _slug;
}