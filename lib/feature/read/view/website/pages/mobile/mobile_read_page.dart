import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/core/theme/app_colors.dart';
import 'package:kujitoon/core/utils/responsive.dart';
import 'package:kujitoon/feature/home/view/website/widgets/hoverable_widget.dart';
import 'package:kujitoon/feature/home/view/website/widgets/mobile/footer_widget.dart';
import 'package:kujitoon/feature/read/bloc/comment_bloc.dart';
import 'package:kujitoon/feature/read/bloc/comment_event.dart';
import 'package:kujitoon/feature/read/bloc/comment_state.dart';
import 'package:kujitoon/feature/read/bloc/read_bloc.dart';
import 'package:kujitoon/feature/read/bloc/read_event.dart';
import 'package:kujitoon/feature/read/domain/entities/chapter_infomation_entity.dart';
import 'package:kujitoon/feature/read/view/website/widgets/chapter_dropdown.dart';
import 'package:kujitoon/feature/read/view/website/widgets/comment_widget.dart';
import 'package:kujitoon/feature/read/view/website/widgets/nav_button.dart';
import 'package:kujitoon/feature/read/view/website/widgets/website/chapter_image_web.dart';
import 'package:kujitoon/feature/shared_header/view/widgets/header_widget.dart';

class MobileReadPage extends StatelessWidget {
  final ChapterInfomationEntity chapterInfomationEntity;
  final ScrollController _scrollController = ScrollController();

  MobileReadPage({super.key, required this.chapterInfomationEntity});

  Future<void> nextChapter(BuildContext context) async {
    int indexChapterInList = chapterInfomationEntity.currentIndex + 1;

    context.read<ReadBloc>().add(
      FeatchDataReadEvent(
        listChapters: chapterInfomationEntity.listChapters,
        urlChapter: chapterInfomationEntity
            .listChapters[indexChapterInList]
            .chapterApiData,
        detailComicEntity: chapterInfomationEntity.detailCommicEntity,
        currentIndex: indexChapterInList,
      ),
    );
  }

  Future<void> backChapter(BuildContext context) async {
    int indexChapterInList = chapterInfomationEntity.currentIndex - 1;
    context.read<ReadBloc>().add(
      FeatchDataReadEvent(
        listChapters: chapterInfomationEntity.listChapters,
        urlChapter: chapterInfomationEntity
            .listChapters[indexChapterInList]
            .chapterApiData,
        detailComicEntity: chapterInfomationEntity.detailCommicEntity,
        currentIndex: indexChapterInList,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedBuilder(
        animation: _scrollController,
        builder: (context, _) {
          final show = _scrollController.hasClients &&
              _scrollController.offset > 100;

          return show
              ? HoverableWidget(
                  onTap: () {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF6A5AE0),
                          Color(0xFF8F7CFF),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                )
              : const SizedBox.shrink();
        },
      ),
      body: Stack(
        children: [
          Column(
            children: [
              /// CONTENT
              SizedBox(height: 100,),
              Expanded(
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    /// ===== TOP BAR =====
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 19,
                          horizontal: 10,
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1199),
                            child: Container(
                              height: 59,
                              padding:
                              const EdgeInsets.symmetric(horizontal: 19),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: chapterInfomationEntity
                                                .detailCommicEntity
                                                .title,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                            ' - Chapter ${chapterInfomationEntity.chapterEntity.chapterName}',
                                          ),
                                        ],
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                  if (chapterInfomationEntity.currentIndex > -1) ...[
                                    NavButton(
                                      text: 'Trang Trước',
                                      onPressed: () async {
                                        await backChapter(context);
                                      },
                                    ),
                                    const SizedBox(width: 7),
                                  ],

                                  ChapterDropdown(chapterInfomationEntity),
                                  const SizedBox(width: 7),

                                  if (chapterInfomationEntity.currentIndex <
                                      chapterInfomationEntity
                                          .listChapters.length -
                                          1)
                                    NavButton(
                                      text: 'Trang Sau',
                                      onPressed: () async {
                                        await nextChapter(context);
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// ===== IMAGES =====
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          final imageChapter =
                          chapterInfomationEntity
                              .chapterEntity
                              .listChapterImages[index];

                          final imageUrl =
                              "${chapterInfomationEntity.chapterEntity.domainCDN}"
                              "/${chapterInfomationEntity.chapterEntity.chapterPath}"
                              "/$imageChapter";

                          return Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                Responsive.isDesktop(context)
                                    ? 1199
                                    : double.infinity,
                              ),
                              child: ChapterImageWeb(
                                imageUrl: imageUrl,
                              ),
                            ),
                          );
                        },
                        childCount: chapterInfomationEntity
                            .chapterEntity
                            .listChapterImages
                            .length,
                      ),
                    ),

                    /// ===== BOTTOM NAV + COMMENT =====
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(height: 19),

                          Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                Responsive.isDesktop(context)
                                    ? 1199
                                    : double.infinity,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  if (chapterInfomationEntity.currentIndex >
                                      -1)
                                    NavButton(
                                      text: 'Trang Trước',
                                      onPressed: () async {
                                        await backChapter(context);
                                      },
                                    ),

                                  const SizedBox(width: 7),

                                  Container(
                                    height: 35,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEFEFEE),
                                      borderRadius:
                                      BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Chapter ${chapterInfomationEntity.chapterEntity.chapterName}",
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 7),

                                  if (chapterInfomationEntity.currentIndex <
                                      chapterInfomationEntity
                                          .listChapters.length -
                                          1)
                                    NavButton(
                                      text: 'Trang Sau',
                                      onPressed: () async {
                                        await nextChapter(context);
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 19),

                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 9),
                            child: CommentWidget(
                              slug: chapterInfomationEntity
                                  .detailCommicEntity
                                  .slug,
                              chapter: int.tryParse(
                                chapterInfomationEntity
                                    .chapterEntity
                                    .chapterName,
                              ) ??
                                  -1,
                            ),
                          ),

                          const SizedBox(height: 19),

                          FooterWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          HeaderWidget(),
        ],
      ),
    );
  }
}

