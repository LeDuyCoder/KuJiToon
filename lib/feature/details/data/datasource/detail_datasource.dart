import 'package:kujitoon/core/model/detail_commic_dto.dart';
import 'package:kujitoon/core/service/detail_commic_service.dart';
import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/domain/entities/last_chapter_entity.dart';
import 'package:kujitoon/feature/details/domain/entities/tag_entity.dart';

class DetailDatasource {

  Future<DetailCommicEntity?> featchData(String slug) async {
    DetailCommicService service = DetailCommicService();
    DetailCommicDto? detailCommicDto = await service.call(slug);
    if(detailCommicDto == null){
      return null;
    }

    DetailCommicEntity detailCommicEntity = DetailCommicEntity(
        slug: slug,
        title: detailCommicDto.title,
        description: detailCommicDto.description,
        urlImage: detailCommicDto.urlImage,
        status: detailCommicDto.status,
        chapters: (detailCommicDto.chapters).map((chapter){
          return LastChapterEntity(
              name: chapter.name,
              chapterTitle: chapter.chapterTitle,
              fileName: chapter.fileName,
              chapterApiData: chapter.chapterApiData,
              isRead: chapter.isRead
          );
        }).toList(),
        updateAt: detailCommicDto.updateAt,
        tags: detailCommicDto.tags.map((tag){
          return TagEntity(id: tag.id, name: tag.name, slug: tag.slug);
        }).toList(),
        countRead: detailCommicDto.countRead
    );

    return detailCommicEntity;
  }
}