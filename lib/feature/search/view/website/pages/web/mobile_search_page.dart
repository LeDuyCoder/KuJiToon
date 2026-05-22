import 'package:flutter/material.dart';
import 'package:kujitoon/feature/home/view/website/widgets/mobile/footer_widget.dart';
import 'package:kujitoon/feature/home/view/website/widgets/pagination_widget.dart';
import 'package:kujitoon/feature/search/domain/entities/result_search.dart';
import 'package:kujitoon/feature/search/view/website/widgets/mobile/comic_grid.dart';
import 'package:kujitoon/feature/shared_header/view/widgets/header_widget.dart';

class MobileSearchPage extends StatefulWidget{
  final ResultSearch resultSearch;
  final String keyword;
  final String userParagram;

  const MobileSearchPage({super.key, required this.resultSearch, required this.keyword, required this.userParagram});

  @override
  State<StatefulWidget> createState() => _MobileSearchPageState();

}

class _MobileSearchPageState extends State<MobileSearchPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: const Color(0xFFF6F7FB),
        body: Column(
          children: [
            /// ================= HEADER (FULL WIDTH) =================
            HeaderWidget(keyword: widget.keyword),

            const SizedBox(height: 20),

            /// ================= BODY =================
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(

                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Result summary box
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Text(
                            'Tìm thấy ${widget.resultSearch.totalItem} kết quả phù hợp "${widget.keyword}"',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        Expanded(
                          child: ComicGrid(
                            comics: widget.resultSearch.prominentComics, userParagram: widget.userParagram,
                          ),
                        ),
                        SizedBox(height: 10,),
                        PaginationWidget(currentPage: widget.resultSearch.currentPage, totalPages: (widget.resultSearch.totalItem / 24).ceil(), onPageChanged: (page){
                          Navigator.pushReplacementNamed(context, "/search?keyword=${widget.keyword}&page=$page");
                        }),
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

}