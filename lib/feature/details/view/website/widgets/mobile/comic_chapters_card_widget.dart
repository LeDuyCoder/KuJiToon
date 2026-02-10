import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kujitoon/core/theme/app_colors.dart';
import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/domain/entities/last_chapter_entity.dart';
import 'package:kujitoon/feature/details/view/website/widgets/chapter_widget.dart';
import 'package:kujitoon/feature/read/view/website/widgets/comment_chat_widget.dart';

class ComicChaptersCardWidget extends StatefulWidget{
  final List<LastChapterEntity> originLastChapters;
  final Iterable<LastChapterEntity> listLastChapters;
  final String selectedSort;
  final DetailCommicEntity detailCommicEntity;
  final void Function(String? type) changeTypeShow;

  const ComicChaptersCardWidget({super.key, required this.listLastChapters, required this.selectedSort, required this.changeTypeShow, required this.originLastChapters, required this.detailCommicEntity});

  @override
  State<StatefulWidget> createState() => _ComicChapterCardWidget();

}

class _ComicChapterCardWidget extends State<ComicChaptersCardWidget>{
  int _visibleCount = 10;

  void _loadMore() {
    setState(() {
      _visibleCount += 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.listLastChapters.length;
    final displayCount = _visibleCount > total ? total : _visibleCount;


    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 5),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.list, color: AppColors.primary, size: 35),
                    SizedBox(width: 8),
                    Text(
                      "Danh Sách Chapter",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 36,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                        value: widget.selectedSort, // placeholder UI
                        icon: Icon(Icons.arrow_drop_down),
                        items: const [
                          DropdownMenuItem(
                            value: "new",
                            child: Text("Mới nhất"),
                          ),
                          DropdownMenuItem(
                            value: "old",
                            child: Text("Cũ nhất"),
                          ),
                        ],
                        onChanged: widget.changeTypeShow
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(thickness: 1),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayCount + 1, // +1 cho nút "Xem thêm"
            itemBuilder: (context, index) {
              // 👉 Item "Xem thêm"
              if (index == displayCount) {
                if (displayCount == total) return const SizedBox.shrink();

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: ElevatedButton.icon(
                      onPressed: _loadMore,
                      icon: const Icon(Icons.expand_more, color: AppColors.primary,),
                      label: const Text(
                        "Xem thêm 10 chương",
                        style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.primary),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                );
              }

              final realIndex = widget.selectedSort == "new"
                  ? index
                  : (widget.listLastChapters.length - 1) - index;

              return ChapterWidget(
                chapterEntity: widget.listLastChapters.elementAt(index),
                chapterEntities: widget.originLastChapters,
                detailCommicEntity: widget.detailCommicEntity,
                currentIndex: realIndex,
              );
            },
          )
        ],
      ),
    );
  }
}