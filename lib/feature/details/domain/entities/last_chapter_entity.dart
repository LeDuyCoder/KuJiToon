class LastChapterEntity {
  final String _name;
  final String _chapterTitle;
  final String _fileName;
  final String _chapterApiData;
  bool isRead;

  LastChapterEntity({
    required String name,
    required String chapterTitle,
    required String fileName,
    required String chapterApiData,
    required this.isRead
  })  : _name = name,
        _chapterTitle = chapterTitle,
        _fileName = fileName,
        _chapterApiData = chapterApiData;

  String get chapterApiData => _chapterApiData;
  String get fileName => _fileName;
  String get chapterTitle => _chapterTitle;
  String get name => _name;

  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'chapterTitle': _chapterTitle,
      'fileName': _fileName,
      'chapterApiData': _chapterApiData,
      'isRead': isRead
    };
  }

  factory LastChapterEntity.fromJson(Map<String, dynamic> json) {
    return LastChapterEntity(
      name: json['name'] as String,
      chapterTitle: json['chapterTitle'] as String,
      fileName: json['fileName'] as String,
      chapterApiData: json['chapterApiData'] as String,
      isRead: json['isRead'] as bool,
    );
  }
}