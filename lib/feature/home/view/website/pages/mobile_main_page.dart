import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/core/theme/app_colors.dart';
import 'package:kujitoon/feature/home/bloc/home_bloc.dart';
import 'package:kujitoon/feature/home/bloc/home_event.dart';
import 'package:kujitoon/feature/home/bloc/home_state.dart';
import 'package:kujitoon/feature/home/view/website/widgets/mobile/footer_widget.dart';
import 'package:kujitoon/feature/home/view/website/widgets/mobile/grid_commic_widget.dart';
import 'package:kujitoon/feature/home/view/website/widgets/prominent_commic_widget.dart';
import 'package:kujitoon/feature/home/view/website/widgets/scroll_button.dart';

class MainPage extends StatelessWidget{
  final LoadedHomeState state;
  final ScrollController _scrollController = ScrollController();

  MainPage({super.key, required this.state});

  void _scrollBy(double offset) {
    _scrollController.animateTo(
      _scrollController.offset + offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    var _widget = MediaQuery.sizeOf(context).width;
    var _hight = MediaQuery.sizeOf(context).height;

    return SizedBox(
        width: _widget,
        height: _hight,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 120,),
                          Container(
                              width: _widget*0.95,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Chào mừng trở lại, ${state.dataEntity.userEntity.name}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: AppColors.white, fontFamily: "EncodeSans"),),
                                    Text("Khám phá thế giới truyện tranh đa dạng và tiếp tục hành trình đọc truyện của bạn.", style: TextStyle(fontSize: 15, color: AppColors.white, fontFamily: "EncodeSans"),)
                                  ],
                                ),
                              )
                          ),
                          SizedBox(height: 20,),
                          //Truyện nổi bật
                          Container(
                            width: _widget*0.95,
                            height: 220,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5
                                  )
                                ]
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                  child: Text(
                                    "Truyện Nổi Bật",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10),
                                        child: Scrollbar(
                                          controller: _scrollController,
                                          thumbVisibility: true,
                                          child: ListView.builder(
                                            controller: _scrollController,
                                            scrollDirection: Axis.horizontal,
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            itemCount: state.dataEntity.listProminentCommic
                                                .listProminentCommics.length,
                                            itemBuilder: (context, index) {
                                              final commic = state.dataEntity.listProminentCommic
                                                  .listProminentCommics[index];
                                              return Padding(
                                                padding: const EdgeInsets.only(right: 12),
                                                child: Align(
                                                    alignment: Alignment.topCenter,
                                                    child: ProminentCommicWidget(
                                                      prominentCommic: commic,
                                                      userEntity: state.dataEntity.userEntity,
                                                    )
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      /// LEFT BUTTON
                                      Positioned(
                                        left: 5,
                                        top: 0,
                                        bottom: 0,
                                        child: ScrollButton(
                                          icon: Icons.chevron_left,
                                          onTap: () {
                                            _scrollBy(-300);
                                          },
                                        ),
                                      ),

                                      /// RIGHT BUTTON
                                      Positioned(
                                        right: 5,
                                        top: 0,
                                        bottom: 0,
                                        child: ScrollButton(
                                          icon: Icons.chevron_right,
                                          onTap: () {
                                            _scrollBy(300);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20,),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          //All Truyện
                          Container(
                              width: _widget*0.95,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5
                                    )
                                  ]
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 10,),
                                  GridCommicWidget(totalPages: state.dataEntity.listLastUpdateCommic.totalPages, onPageChanged: (int p) {
                                    context.read<HomeBloc>().add(ChangePageHomeDataEvent(page: p, oldDataEntity: state.dataEntity));
                                  }, lastUpdateCommics: state.dataEntity.listLastUpdateCommic.listLastUpdateCommics, currentPage: state.dataEntity.listLastUpdateCommic.currentPage, userEntity: state.dataEntity.userEntity,),
                                ],
                              )
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      FooterWidget()
                    ],
                  )
              ),
            ),
          ],
        )
    );
  }

}