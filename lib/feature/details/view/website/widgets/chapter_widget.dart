import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kujitoon/core/routes/fade_route.dart';
import 'package:kujitoon/core/theme/app_colors.dart';
import 'package:kujitoon/core/utils/time_ago.dart';
import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/domain/entities/last_chapter_entity.dart';

class ChapterWidget extends StatelessWidget{
  final List<LastChapterEntity> chapterEntities;
  final LastChapterEntity chapterEntity;
  final DetailCommicEntity detailCommicEntity;
  final int currentIndex;

  const ChapterWidget({super.key, required this.chapterEntity, required this.chapterEntities, required this.detailCommicEntity, required this.currentIndex});

  DateTime getCreatedDateFromObjectId(String objectId) {
    final timestampHex = objectId.substring(0, 8);
    final timestamp = int.parse(timestampHex, radix: 16);
    return DateTime.fromMillisecondsSinceEpoch(
      timestamp * 1000,
      isUtc: true,
    ).toLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Chapter ${chapterEntity.name}",
            style: TextStyle(
              fontSize: 16,
              fontWeight:
              chapterEntity.isRead ? FontWeight.normal : FontWeight.bold,
              color:
              chapterEntity.isRead ? Colors.grey : AppColors.primary,
            ),
          ),

          Row(
            children: [
              Text(
                TimeAgo.time(getCreatedDateFromObjectId(chapterEntity.chapterApiData.split("chapter/")[1]),),
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 12),
              ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(
                    context,
                    '/read',
                    arguments: {
                      'chapters': chapterEntities, // List<ChapterEntity>
                      'urlChapter': chapterEntity.chapterApiData, // String
                      'detailComicEntity': detailCommicEntity,
                      'currentIndexChapter': currentIndex
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: chapterEntity.isRead
                      ? Colors.grey
                      : AppColors.primary,
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Đọc ngay",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}