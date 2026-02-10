class ChapterEntity {
  final String _domainCDN;
  final String _chapterPath;
  final List<String> _listChapterImages;
  final String _chapterName;

  ChapterEntity({
    required String domainCDN,
    required String chapterPath,
    required List<String> listChapterImages,
    required String chapterName
  }) : _domainCDN = domainCDN,
        _chapterPath = chapterPath,
        _listChapterImages = listChapterImages,
        _chapterName = chapterName;

  List<String> get listChapterImages => _listChapterImages;
  String get chapterPath => _chapterPath;
  String get domainCDN => _domainCDN;
  String get chapterName => _chapterName;
}