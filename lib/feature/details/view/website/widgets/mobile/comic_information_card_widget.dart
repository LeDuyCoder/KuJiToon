import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kujitoon/core/enum/status_enum.dart';
import 'package:kujitoon/core/theme/app_colors.dart';
import 'package:kujitoon/core/utils/format_number.dart';
import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/view/website/widgets/info_item.dart';
import 'package:kujitoon/feature/details/view/website/widgets/tag_widget.dart';

class ComicInformationCardWidget extends StatelessWidget{
  final DetailCommicEntity detailCommicEntity;

  const ComicInformationCardWidget({super.key, required this.detailCommicEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 10
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Text(
              detailCommicEntity.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              softWrap: true,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "Tác giả: ",
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                    ),
                    softWrap: true,
                  ),
                  Text(
                    "Chưa Xác Định",
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                    softWrap: true,
                  ),
                ],
              )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Html(
              data: detailCommicEntity.description,
              style: {
                "body": Style(
                  fontSize: FontSize(12),
                  color: Colors.black87,
                ),
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                color: const Color(0xFFF5F7FA),
                borderRadius: BorderRadius.circular(12),
                border: Border(
                  left: BorderSide(
                      color: AppColors.primary
                  ),
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoItem(
                  title: FormatNumber.formatNumber(detailCommicEntity.count),
                  subtitle: 'Lượt Xem',
                ),
                InfoItem(
                  title: "${detailCommicEntity.chapters.length}",
                  subtitle: 'Chapter',
                ),
                InfoItem(
                  title: detailCommicEntity.status.value,
                  subtitle: 'Trạng Thái',
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
            child: Wrap(
              spacing: 10,      // khoảng cách ngang giữa các tag
              runSpacing: 8,    // khoảng cách dọc khi xuống dòng
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text(
                  "Thể Loại:",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...detailCommicEntity.tags.map(
                      (tag) => TagWidget(content: tag.name),
                ),

              ],
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }

}