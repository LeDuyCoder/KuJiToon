import 'package:kujitoon/core/enum/status_enum.dart';
import 'package:kujitoon/feature/details/domain/entities/last_chapter_entity.dart';
import 'package:kujitoon/feature/details/domain/entities/tag_entity.dart';

class DetailCommicEntity {
  final String _slug;
  final String _title;
  final String _urlImage;
  final String _description;
  final StatusEnum _status;
  final List<LastChapterEntity> _chapters;
  final DateTime _updateAt;
  final List<TagEntity> _tags;
  final int _countRead;

  DetailCommicEntity({
    required String slug,
    required String title,
    required String description,
    required String urlImage,
    required StatusEnum status,
    required List<LastChapterEntity> chapters,
    required DateTime updateAt,
    required List<TagEntity> tags,
    required int countRead,
  }) : _slug = slug,
        _title = title,
        _description = description,
        _urlImage = urlImage,
        _status = status,
        _chapters = chapters,
        _updateAt = updateAt,
        _tags = tags,
        _countRead = countRead;

  List<TagEntity> get tags => _tags;
  DateTime get updateAt => _updateAt;
  List<LastChapterEntity> get chapters => _chapters;
  String get urlImage => _urlImage;
  StatusEnum get status => _status;
  String get description => _description;
  String get title => _title;
  String get slug => _slug;
  int get count => _countRead;
}