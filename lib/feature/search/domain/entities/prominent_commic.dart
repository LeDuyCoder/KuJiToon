import 'package:kujitoon/feature/search/domain/entities/category.dart';

class ProminentCommic {
  final String name;
  final String slug;
  final String originName;
  final String ongoing;
  final String thumbUrl;
  final List<Category> categories;

  ProminentCommic({required this.name, required this.slug, required this.originName, required this.ongoing, required this.thumbUrl, required this.categories});

  factory ProminentCommic.fromJson(Map<String, dynamic> json) {
    return ProminentCommic(
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      originName: json['origin_name'] ?? '',
      ongoing: json['ongoing']?.toString() ?? '',
      thumbUrl: json['thumb_url'] ?? '',
      categories: (json["category"] as List).map((category) => Category.fromJson(category)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'slug': slug,
      'origin_name': originName,
      'ongoing': ongoing,
      'thumb_url': thumbUrl,
    };
  }
}