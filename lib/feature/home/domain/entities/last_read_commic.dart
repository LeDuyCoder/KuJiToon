import 'package:kujitoon/core/enum/status_enum.dart';

class LastReadCommic {
  final String urlImage;
  final String slug;
  final String title;
  final List<String> tags;
  final int historyChapterRead;
  final int lastChapter;
  final StatusEnum status;
  final DateTime updatedAt;

  LastReadCommic({
    required this.urlImage,
    required this.slug,
    required this.title,
    required this.tags,
    required this.historyChapterRead,
    required this.lastChapter,
    required this.status,
    required this.updatedAt,
  });
}