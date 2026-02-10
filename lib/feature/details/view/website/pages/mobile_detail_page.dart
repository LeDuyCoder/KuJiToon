import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/domain/entities/last_chapter_entity.dart';
import 'package:kujitoon/feature/details/view/website/widgets/mobile/comic_chapters_card_widget.dart';
import 'package:kujitoon/feature/details/view/website/widgets/mobile/comic_information_card_widget.dart';
import 'package:kujitoon/feature/details/view/website/widgets/mobile/comic_overview_card_widget.dart';
import 'package:kujitoon/feature/home/domain/entities/user_entity.dart';
import 'package:kujitoon/feature/home/view/website/widgets/mobile/footer_widget.dart';
import 'package:kujitoon/feature/home/view/website/widgets/mobile/menu_widget.dart';
import 'package:kujitoon/feature/shared_header/view/widgets/header_widget.dart';

class MobileDetailPage extends StatefulWidget{
  final DetailCommicEntity detailCommicEntity;
  final UserEntity userEntity;

  const MobileDetailPage({super.key, required this.detailCommicEntity, required this.userEntity});

  @override
  State<StatefulWidget> createState() => _MobileDetailPage();
}

class _MobileDetailPage extends State<MobileDetailPage>{
  bool isOpenMenu = false;
  String selectedSort = "new";

  @override
  Widget build(BuildContext context) {

    late Iterable<LastChapterEntity> listLastChapters;

    if(selectedSort == "new"){
      listLastChapters = widget.detailCommicEntity.chapters.reversed;
    }else{
      listLastChapters = widget.detailCommicEntity.chapters;
    }

    return Scaffold(
      body: Stack(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 90,),
                  ComicOverviewCardWidget(urlImage: widget.detailCommicEntity.urlImage,),
                  ComicInformationCardWidget(detailCommicEntity: widget.detailCommicEntity),
                  SizedBox(height: 20,),
                  ComicChaptersCardWidget(listLastChapters: listLastChapters, selectedSort: selectedSort, changeTypeShow: (value){
                    setState(() {
                      selectedSort = value??'new';
                    });
                  }, originLastChapters: widget.detailCommicEntity.chapters.toList(),
                    detailCommicEntity: widget.detailCommicEntity,),
                  SizedBox(height: 40,),
                  FooterWidget()
                ],
              ),
            ),
          ),
          Column(
            children: [
              HeaderWidget(),
              if(isOpenMenu)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  height: isOpenMenu ? 250 : 0,
                  child: ClipRect(
                    child: MenuWidget(changePage: (String page) {}, userEntity: widget.userEntity,),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }

}