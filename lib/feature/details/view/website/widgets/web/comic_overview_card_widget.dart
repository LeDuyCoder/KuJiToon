import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/core/theme/app_colors.dart';
import 'package:kujitoon/feature/details/bloc/detail_bloc.dart';
import 'package:kujitoon/feature/details/bloc/detail_event.dart';
import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/domain/entities/last_chapter_entity.dart';
import 'package:kujitoon/feature/details/view/cubit/button_cubit.dart';
import 'package:kujitoon/feature/details/view/cubit/button_state.dart';
import 'package:kujitoon/feature/details/view/cubit/follow_button_cubit.dart';
import 'package:kujitoon/feature/details/view/website/widgets/web/follow_button_widget.dart';

class ComicOverviewCardWidget extends StatefulWidget{

  final String urlImage;
  final URL_BASE = "https://img.otruyenapi.com/uploads/comics/";

  final List<LastChapterEntity> originLastChapters;
  final DetailCommicEntity detailCommicEntity;

  const ComicOverviewCardWidget({super.key, required this.urlImage, required this.originLastChapters, required this.detailCommicEntity});

  @override
  State<StatefulWidget> createState() => _ComicOverviewCardWidget();

}

class _ComicOverviewCardWidget extends State<ComicOverviewCardWidget>{
  @override
  void initState() {
    super.initState();
    context.read<ButtonCubit>().checkReadStatus(widget.detailCommicEntity.slug);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: 220,
      height: 350,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 10
            )
          ]
      ),
      child: Column(
        children: [
          SizedBox(height: 20,),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              "${widget.URL_BASE}${widget.urlImage}",
              width: 160,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10,),
          BlocBuilder<ButtonCubit, ButtonState>(
            builder: (BuildContext context, ButtonState state) {
              return SizedBox(
                width: 180,
                height: 44,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<ButtonCubit>().readComic(context, widget.originLastChapters, widget.detailCommicEntity);
                    context.read<DetailBloc>().add(IncreaseViewEvent(detailCommicEntity: widget.detailCommicEntity));

                    if(state is ContinuteButtonState){
                      context.read<DetailBloc>().add(UpdateChapterReadEvent(chapter: widget.originLastChapters.elementAt(state.indexChapter).name, slug: widget.detailCommicEntity.slug, indexChapter: state.indexChapter));
                      widget.originLastChapters.elementAt(state.indexChapter).isRead = true;
                    }else{
                      context.read<DetailBloc>().add(UpdateChapterReadEvent(chapter: widget.originLastChapters.elementAt(0).name, slug: widget.detailCommicEntity.slug, indexChapter: 0));
                      widget.originLastChapters.elementAt(0).isRead = true;
                    }

                  },
                  icon: const Icon(Icons.play_arrow, size: 20),
                  label: Text(
                    state is StartReadButtonState ? "Đọc Từ Đầu" : "Đọc Tiếp",
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 10,),

          BlocProvider(
            create: (_) => FollowButtonCubit(),
            child: FollowButtonWidget(detailCommicEntity: widget.detailCommicEntity),
          ),

          const SizedBox(height: 10),

        ],
      ),
    );
  }
}