import 'package:kujitoon/feature/home/domain/entities/latest_chapter_commic.dart';

class LastUpdateCommic {
  final String title;
  final String slug;
  final String imageUrl;
  final List<LatestChapterCommic> latestChapters;
  final DateTime updateTime;

  LastUpdateCommic({
    required this.title,
    required this.slug,
    required this.imageUrl,
    required this.latestChapters,
    required this.updateTime,
  });
}