import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kujitoon/core/theme/app_colors.dart';
import 'package:kujitoon/feature/details/domain/entities/last_chapter_entity.dart';
import 'package:kujitoon/feature/details/view/website/widgets/chapter_widget.dart';

class ComicChaptersCardWidget extends StatelessWidget{
  final Iterable<LastChapterEntity> listLastChapters;
  final String selectedSort;
  final void Function(String? type) changeTypeShow;

  const ComicChaptersCardWidget({super.key, required this.listLastChapters, required this.selectedSort, required this.changeTypeShow});


  @override
  Widget build(BuildContext context) {
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
                      value: selectedSort, // placeholder UI
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
                      onChanged: changeTypeShow
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
            physics: NeverScrollableScrollPhysics(),
            itemCount: listLastChapters.length,
            itemBuilder: (context, index) {
              return ChapterWidget(
                chapterEntity: listLastChapters.elementAt(index),
              );
            },
          ),
        ],
      ),
    );
  }

}