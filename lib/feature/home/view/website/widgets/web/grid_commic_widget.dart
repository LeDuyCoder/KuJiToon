import 'package:flutter/cupertino.dart';
import 'package:kujitoon/feature/home/domain/entities/last_update_commic.dart';
import 'package:kujitoon/feature/home/domain/entities/user_entity.dart';
import 'package:kujitoon/feature/home/view/website/widgets/lates_commic_widget.dart';
import 'package:kujitoon/feature/home/view/website/widgets/pagination_widget.dart';
import 'package:kujitoon/feature/home/view/website/widgets/prominent_commic_widget.dart';

class GridCommicWidget extends StatefulWidget{
  final UserEntity userEntity;
  final List<LastUpdateCommic> lastUpdateCommics;
  final int totalPages;
  final int currentPage;
  final Function(int) onPageChanged;

  GridCommicWidget({super.key, required this.totalPages, required this.onPageChanged, required this.lastUpdateCommics, required this.currentPage, required this.userEntity});

  @override
  State<StatefulWidget> createState() => _GridCommicWidgetState();
}

class _GridCommicWidgetState extends State<GridCommicWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: widget.lastUpdateCommics.length,
            shrinkWrap: true, // ⭐ QUAN TRỌNG
            physics: const NeverScrollableScrollPhysics(), // ⭐ Tắt scroll
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              final commic = widget.lastUpdateCommics[index];
              return LatesCommicWidget(lastUpdateCommic: commic, userEntity: widget.userEntity,);
            },
          ),
          PaginationWidget(
            currentPage: widget.currentPage,
            totalPages: widget.totalPages,
            onPageChanged: widget.onPageChanged
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}