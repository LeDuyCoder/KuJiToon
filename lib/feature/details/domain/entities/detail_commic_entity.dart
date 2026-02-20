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
  int countRead;

  DetailCommicEntity({
    required String slug,
    required String title,
    required String description,
    required String urlImage,
    required StatusEnum status,
    required List<LastChapterEntity> chapters,
    required DateTime updateAt,
    required List<TagEntity> tags,
    required this.countRead,
  }) : _slug = slug,
        _title = title,
        _description = description,
        _urlImage = urlImage,
        _status = status,
        _chapters = chapters,
        _updateAt = updateAt,
        _tags = tags;

  List<TagEntity> get tags => _tags;
  DateTime get updateAt => _updateAt;
  List<LastChapterEntity> get chapters => _chapters;
  String get urlImage => _urlImage;
  StatusEnum get status => _status;
  String get description => _description;
  String get title => _title;
  String get slug => _slug;
  int get count => countRead;

  Map<String, dynamic> toJson() {
    return {
      'slug': _slug,
      'title': _title,
      'description': _description,
      'urlImage': _urlImage,
      'status': _status.toJson(),
      'chapters': _chapters.map((e) => e.toJson()).toList(),
      'updateAt': _updateAt.toIso8601String(),
      'tags': _tags.map((e) => e.toJson()).toList(),
      'countRead': countRead,
    };
  }

  factory DetailCommicEntity.fromJson(Map<String, dynamic> json) {
    return DetailCommicEntity(
      slug: json['slug'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      urlImage: json['urlImage'] as String,
      status: StatusEnumX.fromJson(json['status']),
      chapters: (json['chapters'] as List)
          .map((e) => LastChapterEntity.fromJson(e))
          .toList(),
      updateAt: DateTime.parse(json['updateAt']),
      tags: (json['tags'] as List)
          .map((e) => TagEntity.fromJson(e))
          .toList(),
      countRead: json['countRead'] as int,
    );
  }
}