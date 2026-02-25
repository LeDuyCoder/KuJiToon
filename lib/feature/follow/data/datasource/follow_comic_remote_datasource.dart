import 'package:kujitoon/core/model/detail_commic_dto.dart';
import 'package:kujitoon/core/service/detail_commic_service.dart';
import 'package:kujitoon/feature/follow/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/follow/domain/entities/last_chapter_entity.dart';
import 'package:kujitoon/feature/follow/domain/entities/tag_entity.dart';

class FollowComicRemoteDatasource {

  Future<List<DetailCommicEntity>> getAllFollowComicByPageSize(
      List<String> slugs,
      int pageSize,
      int indexPage,
      ) async {
    final List<DetailCommicEntity> result = [];
    final DetailCommicService service = DetailCommicService();

    final int start = indexPage * pageSize;
    if (start >= slugs.length) return result;

    final int end = (start + pageSize) > slugs.length
        ? slugs.length
        : start + pageSize;

    final List<String> pageSlugs = slugs.sublist(start, end);

    for (final slug in pageSlugs) {
      final DetailCommicDto? dto = await service.call(slug);

      if (dto != null) {
        result.add(
          DetailCommicEntity(
            slug: slug,
            title: dto.title,
            description: dto.description,
            urlImage: dto.urlImage,
            status: dto.status,
            chapters: dto.chapters.map((chapter) {
              return LastChapterEntity(
                name: chapter.name,
                chapterTitle: chapter.chapterTitle,
                fileName: chapter.fileName,
                chapterApiData: chapter.chapterApiData,
                isRead: chapter.isRead,
              );
            }).toList(),
            updateAt: dto.updateAt,
            tags: dto.tags.map((tag) {
              return TagEntity(
                id: tag.id,
                name: tag.name,
                slug: tag.slug,
              );
            }).toList(),
            countRead: dto.countRead,
          ),
        );
      }
    }

    return result;
  }
}