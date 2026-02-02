class TagDto {
  final String _id;
  final String _name;
  final String _slug;

  TagDto({required String id, required String name, required String slug}) : _id = id, _name = name, _slug = slug;

  String get slug => _slug;
  String get name => _name;
  String get id => _id;
}