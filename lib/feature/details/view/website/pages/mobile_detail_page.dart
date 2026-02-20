import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/domain/entities/last_chapter_entity.dart';
import 'package:kujitoon/feature/details/view/cubit/button_cubit.dart';
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
          /// ===== CONTENT (SCROLL) =====
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 90),
              child: Column(
                children: [
                  BlocProvider(
                    create: (_) => ButtonCubit(),
                    child: ComicOverviewCardWidget(
                      urlImage: widget.detailCommicEntity.urlImage,
                      originLastChapters: widget.detailCommicEntity.chapters.toList(),
                      detailCommicEntity: widget.detailCommicEntity,
                    ),
                  ),

                  ComicInformationCardWidget(
                    detailCommicEntity: widget.detailCommicEntity,
                  ),

                  const SizedBox(height: 20),

                  /// 🔥 CHAPTER CARD (ĐÂY NÈ)
                  ComicChaptersCardWidget(
                    listLastChapters: listLastChapters,
                    selectedSort: selectedSort,
                    changeTypeShow: (value) {
                      setState(() {
                        selectedSort = value ?? 'new';
                      });
                    },
                    originLastChapters:
                    widget.detailCommicEntity.chapters.toList(),
                    detailCommicEntity: widget.detailCommicEntity,
                  ),

                  const SizedBox(height: 40),

                  FooterWidget(),
                ],
              ),
            ),
          ),

          /// ===== HEADER (FIXED) =====
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: HeaderWidget(),
          ),

          /// ===== MENU =====
          Positioned(
            top: 90,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              height: isOpenMenu ? 250 : 0,
              child: ClipRect(
                child: MenuWidget(
                  changePage: (String page) {},
                  userEntity: widget.userEntity,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}