import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kujitoon/core/theme/app_colors.dart';
import 'package:kujitoon/feature/home/domain/entities/last_update_commic.dart';
import 'package:kujitoon/feature/home/view/website/widgets/hoverable_widget.dart';

class LatesCommicWidget extends StatelessWidget {
  final LastUpdateCommic lastUpdateCommic;

  const LatesCommicWidget({super.key, required this.lastUpdateCommic});

  @override
  Widget build(BuildContext context) {
    return HoverableWidget(
      onTap: (){},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth;

            final titleSize = itemWidth * 0.08; // tự chỉnh
            final subSize = itemWidth * 0.065;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  "https://img.otruyenapi.com/uploads/comics/${lastUpdateCommic.imageUrl}",
                  height: itemWidth * 1.2,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    lastUpdateCommic.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: titleSize.clamp(11, 16),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.book, size: 12, color: AppColors.black),
                      const SizedBox(width: 4),
                      Text(
                        "Cập nhật tới: Chapter ${lastUpdateCommic.latestChapters[0].name}",
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: itemWidth * 0.05,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
