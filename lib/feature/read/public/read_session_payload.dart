class ReadSessionPayload {
  final Map<String, dynamic> detailComic;
  final List<Map<String, dynamic>> chapters;
  final String urlChapter;
  final int currentIndex;

  const ReadSessionPayload({
    required this.detailComic,
    required this.chapters,
    required this.urlChapter,
    required this.currentIndex,
  });

  Map<String, dynamic> toJson() => {
    'detailComic': detailComic,
    'chapters': chapters,
    'urlChapter': urlChapter,
    'currentIndex': currentIndex,
  };

  factory ReadSessionPayload.fromJson(Map<String, dynamic> json) {
    return ReadSessionPayload(
      detailComic: json['detailComic'],
      chapters: List<Map<String, dynamic>>.from(json['chapters']),
      urlChapter: json['urlChapter'],
      currentIndex: json['currentIndex'],
    );
  }
}