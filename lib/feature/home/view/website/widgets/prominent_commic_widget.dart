import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kujitoon/core/theme/app_colors.dart';
import 'package:kujitoon/core/utils/time_ago.dart';
import 'package:kujitoon/feature/home/domain/entities/prominent_commic.dart';
import 'package:kujitoon/feature/home/domain/entities/user_entity.dart';
import 'package:kujitoon/feature/home/view/website/widgets/hoverable_widget.dart';

class ProminentCommicWidget extends StatelessWidget{
  final ProminentCommic prominentCommic;
  final UserEntity userEntity;

  const ProminentCommicWidget({super.key, required this.prominentCommic, required this.userEntity});

  @override
  Widget build(BuildContext context) {
    return HoverableWidget(
      onTap: (){
        Navigator.pushNamed(
          context,
          '/detail',
          arguments: {
            "slug": prominentCommic.slug,
            "userEntity": userEntity
          },
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Image.network(
              "https://img.otruyenapi.com/uploads/comics/${prominentCommic.urlImage}",
              width: 160,
              height: 200,
              fit: BoxFit.cover,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 60,
                color: AppColors.black.withAlpha(230),
                child: Column(
                  children: [
                    SizedBox(height: 5,),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Text(
                        prominentCommic.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.clock, size: 12, color: AppColors.white),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    TimeAgo.time(prominentCommic.updatedAt),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: AppColors.white, fontSize: 11),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: [
                              Icon(Icons.book, size: 12, color: AppColors.white),
                              const SizedBox(width: 4),
                              Text(
                                "${prominentCommic.chapterCount}",
                                style: const TextStyle(color: AppColors.white, fontSize: 11),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}