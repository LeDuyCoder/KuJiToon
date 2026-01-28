import 'package:kujitoon/core/enum/status_enum.dart';

class CommicDTO {
  final String _slug;
  final String _title;
  final String _description;
  final String _imageUrl;
  final List<String> _tags;
  final StatusEnum _status;
  final DateTime _createdAt;

  CommicDTO({
    required String slug,
    required String title,
    required String description,
    required String imageUrl,
    required List<String> tags,
    required StatusEnum status,
    required DateTime createdAt,
  })  : _slug = slug,
        _title = title,
        _description = description,
        _imageUrl = imageUrl,
        _tags = tags,
        _status = status,
        _createdAt = createdAt;

  DateTime get createdAt => _createdAt;

  StatusEnum get status => _status;

  List<String> get tags => _tags;

  String get imageUrl => _imageUrl;

  String get description => _description;

  String get title => _title;

  String get slug => _slug;
}