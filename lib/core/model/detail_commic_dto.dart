import 'package:kujitoon/core/enum/status_enum.dart';
import 'package:kujitoon/core/model/last_chapter_dto.dart';
import 'package:kujitoon/core/model/tag_dto.dart';

class DetailCommicDto {
  final String _slug;
  final String _title;
  final String _urlImage;
  final String _description;
  final StatusEnum _status;
  final List<LastChapterDto> _chapters;
  final DateTime _updateAt;
  final List<TagDto> _tags;
  final int _countRead;

  DetailCommicDto({
    required String slug,
    required String title,
    required String description,
    required String urlImage,
    required StatusEnum status,
    required List<LastChapterDto> chapters,
    required DateTime updateAt,
    required List<TagDto> tags,
    required int countRead
  }) : _slug = slug,
       _title = title,
       _description = description,
       _urlImage = urlImage,
       _status = status,
       _chapters = chapters,
       _updateAt = updateAt,
       _tags = tags,
       _countRead = countRead;

  List<TagDto> get tags => _tags;
  DateTime get updateAt => _updateAt;
  List<LastChapterDto> get chapters => _chapters;
  String get urlImage => _urlImage;
  StatusEnum get status => _status;
  String get description => _description;
  String get title => _title;
  String get slug => _slug;
  int get countRead => _countRead;
}
