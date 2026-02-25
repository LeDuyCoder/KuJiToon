import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/core/utils/time_ago.dart';
import 'package:kujitoon/feature/details/bloc/detail_bloc.dart';
import 'package:kujitoon/feature/details/bloc/detail_event.dart';
import 'package:kujitoon/feature/follow/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/follow/view/website/widget/web/chapter_item.dart';
import 'package:kujitoon/feature/home/domain/entities/user_entity.dart';
import 'package:kujitoon/feature/home/view/website/widgets/hoverable_widget.dart';

class DetailComicCard extends StatelessWidget {
  final DetailCommicEntity detailCommicEntity;
  final UserEntity userEntity;

  final URL_BASE = "https://img.otruyenapi.com/uploads/comics/";

  const DetailComicCard({
    super.key,
    required this.detailCommicEntity, required this.userEntity,
  });

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
    return HoverableWidget(
      child: Container(
        height: 350,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // 🔥 quan trọng
          children: [
            // ================= IMAGE =================
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  Image.network(
                    "$URL_BASE${detailCommicEntity.urlImage}",
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${detailCommicEntity.countRead ?? 0}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),
            
            HoverableWidget(
              child: Row(
                children: [
                  Icon(Icons.close, color: Colors.red, size: 14, fontWeight: FontWeight.bold,),
                  Text("Bỏ Theo Dõi", style: TextStyle(color: Colors.red, fontSize: 12),)
                ],
              ),
              onTap: (){},
            ),
            
            const SizedBox(height: 8,),
            // ================= TITLE =================
            Text(
              detailCommicEntity.title ?? 'Không có tiêu đề',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            // ================= STATUS =================
            for(var i = 0; i < 3; i++) ...[
              ChapterItem(
                title: detailCommicEntity.chapters[detailCommicEntity.chapters.length - 1 - i].name,
                time: TimeAgo.time(getCreatedDateFromObjectId(detailCommicEntity.chapters[detailCommicEntity.chapters.length - 1 - i].chapterApiData.split("chapter/")[1])),
                isRead: detailCommicEntity.chapters[detailCommicEntity.chapters.length - 1 - i].isRead,
                onTap: (){},
              )
            ]
          ],
        ),
      ),
      onTap: (){
        final uri = Uri(
          path: '/detail',
          queryParameters: {
            'slug': detailCommicEntity.slug,
            ...userEntity.toQueryParams(), // 👈 gộp object vào đây
          },
        );

        Navigator.pushNamed(context, uri.toString());
      },
    );
  }
}