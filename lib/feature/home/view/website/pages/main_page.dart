import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/core/theme/app_colors.dart';
import 'package:kujitoon/feature/home/bloc/home_bloc.dart';
import 'package:kujitoon/feature/home/bloc/home_event.dart';
import 'package:kujitoon/feature/home/bloc/home_state.dart';
import 'package:kujitoon/feature/home/view/website/widgets/grid_commic_widget.dart';
import 'package:kujitoon/feature/home/view/website/widgets/prominent_commic_widget.dart';
import 'package:kujitoon/feature/home/view/website/widgets/scroll_button.dart';

class MainPage extends StatelessWidget{
  final BuildContext context;
  final LoadedHomeState state;

  MainPage({super.key, required this.context, required this.state});

  final ScrollController _scrollController = ScrollController();

  void _scrollBy(double offset) {
    _scrollController.animateTo(
      _scrollController.offset + offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            height: 280,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withAlpha(40),
                  blurRadius: 6,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Truyện Nổi Bật",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                /// CONTENT
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
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withAlpha(40),
                  blurRadius: 6,
                )
              ],
            ),
            child: GridCommicWidget(totalPages: state.dataEntity.listLastUpdateCommic.totalPages, onPageChanged: (int p) {
              context.read<HomeBloc>().add(ChangePageHomeDataEvent(page: p, oldDataEntity: state.dataEntity));
            }, lastUpdateCommics: state.dataEntity.listLastUpdateCommic.listLastUpdateCommics, currentPage: state.dataEntity.listLastUpdateCommic.currentPage,),
          ),
        ],
      ),
    );
  }

}