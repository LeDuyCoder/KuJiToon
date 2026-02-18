import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/core/theme/app_colors.dart';
import 'package:kujitoon/core/utils/responsive.dart';
import 'package:kujitoon/feature/home/view/website/widgets/mobile/footer_widget.dart';
import 'package:kujitoon/feature/read/bloc/read_bloc.dart';
import 'package:kujitoon/feature/read/bloc/read_event.dart';
import 'package:kujitoon/feature/read/domain/entities/chapter_infomation_entity.dart';
import 'package:kujitoon/feature/read/view/website/widgets/chapter_dropdown.dart';
import 'package:kujitoon/feature/read/view/website/widgets/comment_widget.dart';
import 'package:kujitoon/feature/read/view/website/widgets/nav_button.dart';
import 'package:kujitoon/feature/read/view/website/widgets/website/chapter_image_web.dart';
import 'package:kujitoon/feature/shared_header/view/widgets/header_widget.dart';

class WebReadPage extends StatelessWidget {
  final ChapterInfomationEntity chapterInfomationEntity;

  WebReadPage({super.key, required this.chapterInfomationEntity});

  final ScrollController _scrollController = ScrollController();

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
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          HeaderWidget(),
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // ===== TOOLBAR (SCROLL CHUNG) =====
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Container(
                        height: 60,
                        width: width,
                        constraints: const BoxConstraints(maxWidth: 1200),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 6),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 18,
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
                              ),
                            ),
                            if (chapterInfomationEntity.currentIndex > 0)
                              NavButton(
                                text: 'Trang Trước',
                                onPressed: () async {
                                  await backChapter(context);
                                },
                              ),
                            const SizedBox(width: 8),
                            ChapterDropdown(chapterInfomationEntity),
                            const SizedBox(width: 8),
                            if (chapterInfomationEntity.currentIndex <
                                chapterInfomationEntity.listChapters.length - 1)
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

                // ===== IMAGE LIST =====
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final imageChapter = chapterInfomationEntity
                          .chapterEntity
                          .listChapterImages[index];

                      final imageUrl =
                          "${chapterInfomationEntity.chapterEntity.domainCDN}"
                          "/${chapterInfomationEntity.chapterEntity.chapterPath}"
                          "/$imageChapter";

                      return Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: Responsive.isDesktop(context)
                                ? 1200
                                : double.infinity,
                          ),
                          child: ChapterImageWeb(imageUrl: imageUrl),
                        ),
                      );
                    },
                    childCount: chapterInfomationEntity
                        .chapterEntity
                        .listChapterImages
                        .length,
                  ),
                ),

                //===== BOTTOM SPACE =====
                const SliverToBoxAdapter(child: SizedBox(height: 40)),

                SliverToBoxAdapter(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: Responsive.isDesktop(context)
                          ? 1200
                          : MediaQuery.sizeOf(context).width * 0.8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (chapterInfomationEntity.currentIndex > 0)
                          NavButton(
                            text: 'Trang Trước',
                            onPressed: () async {
                              await backChapter(context);
                            },
                          ),
                        const SizedBox(width: 8),
                        Container(
                          height: 36,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFEFEF),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Text(
                              "Chapter ${chapterInfomationEntity.chapterEntity.chapterName}",
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (chapterInfomationEntity.currentIndex <
                            chapterInfomationEntity.listChapters.length - 1)
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
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: Responsive.isDesktop(context)
                              ? 1200
                              : MediaQuery.sizeOf(context).width * 0.8,
                        ),
                        child:  CommentWidget(
			         slug: chapterInfomationEntity.detailCommicEntity.slug,  
				 chapter: int.tryParse(chapterInfomationEntity.chapterEntity.chapterName,) ?? 0, 
			       ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                SliverToBoxAdapter(child: FooterWidget()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
