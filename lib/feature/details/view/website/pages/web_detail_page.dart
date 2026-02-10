import 'package:flutter/material.dart';
import 'package:kujitoon/core/utils/responsive.dart';
import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/domain/entities/last_chapter_entity.dart';
import 'package:kujitoon/feature/details/view/website/widgets/mobile/comic_information_card_widget.dart';
import 'package:kujitoon/feature/details/view/website/widgets/web/comic_chapters_card_widget.dart';
import 'package:kujitoon/feature/details/view/website/widgets/web/comic_overview_card_widget.dart';
import 'package:kujitoon/feature/home/view/website/widgets/mobile/footer_widget.dart';
import 'package:kujitoon/feature/shared_header/view/widgets/header_widget.dart';

class WebDetailPage extends StatefulWidget {
  final DetailCommicEntity detailCommicEntity;
  const WebDetailPage({super.key, required this.detailCommicEntity});

  @override
  State<StatefulWidget> createState() => _WebDetailPage();
}

class _WebDetailPage extends State<WebDetailPage> {
  String selectedSort = "new";

  @override
  Widget build(BuildContext context) {
    Iterable<LastChapterEntity> listLastChapters;

    if (selectedSort == "new") {
      listLastChapters = widget.detailCommicEntity.chapters.reversed;
    } else {
      listLastChapters = widget.detailCommicEntity.chapters;
    }

    return Scaffold(
      body: Column(
        children: [
          HeaderWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 40, right: 40),
                      constraints: BoxConstraints(
                        maxWidth: Responsive.isDesktop(context)
                            ? 1200
                            : MediaQuery.sizeOf(context).width * 0.8,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ComicOverviewCardWidget(
                            urlImage: widget.detailCommicEntity.urlImage,
                          ),
                          Expanded(
                            child: ComicInformationCardWidget(
                              detailCommicEntity: widget.detailCommicEntity,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    ComicChaptersCardWidget(
                      listLastChapters: listLastChapters,
                      selectedSort: selectedSort,
                      changeTypeShow: (String? value) {
                        setState(() {
                          selectedSort = value ?? "new";
                        });
                      },
                      originLastChapters: widget
                          .detailCommicEntity
                          .chapters
                          .toList(),
                      detailCommicEntity: widget.detailCommicEntity,
                    ),
                    SizedBox(height: 50),
                    FooterWidget(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
