import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kujitoon/core/theme/app_colors.dart';
import 'package:kujitoon/core/utils/responsive.dart';
import 'package:kujitoon/feature/read/domain/entities/chapter_infomation_entity.dart';
import 'package:kujitoon/feature/read/view/website/widgets/chapter_dropdown.dart';
import 'package:kujitoon/feature/read/view/website/widgets/nav_button.dart';
import 'package:kujitoon/feature/read/view/website/widgets/website/chapter_image_web.dart';
import 'package:kujitoon/feature/shared_header/view/widgets/header_widget.dart';

class MobileReadPage extends StatelessWidget {
  final ChapterInfomationEntity chapterInfomationEntity;
  final ScrollController _scrollController = ScrollController();

  MobileReadPage({super.key, required this.chapterInfomationEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// ===== HEADER (KHÔNG SCROLL) =====
        HeaderWidget(),

        /// ===== CONTENT (SCROLL) =====
        Expanded(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              /// ===== TOOLBAR =====
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Container(
                        height: 60,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text.rich(
                                TextSpan(
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
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            if (chapterInfomationEntity.currentIndex > 0) ...[
                              NavButton(text: 'Trang Trước', onPressed: () {}),
                              const SizedBox(width: 8),
                            ],

                            ChapterDropdown(chapterInfomationEntity),
                            const SizedBox(width: 8),

                            if (chapterInfomationEntity.currentIndex <
                                chapterInfomationEntity.listChapters.length -
                                    1)
                              NavButton(text: 'Trang Sau', onPressed: () {}),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

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
            ],
          ),
        ),
      ],
    );
  }
}

