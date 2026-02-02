import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/core/utils/responsive.dart';
import 'package:kujitoon/feature/details/bloc/detail_bloc.dart';
import 'package:kujitoon/feature/details/bloc/detail_state.dart';
import 'package:kujitoon/feature/details/view/website/pages/mobile_detail_page.dart';
import 'package:kujitoon/feature/details/view/website/pages/web_detail_page.dart';
import 'package:kujitoon/feature/loading/view/widgets/loading_widget.dart';

class DetailPage extends StatelessWidget{
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailBloc, DetailState>(
        builder: (context, state){
          if(state is LoadedDetailState){
            return Responsive.isDesktop(context)
                ? WebDetailPage(detailCommicEntity: state.detailCommicEntity)
                : MobileDetailPage(detailCommicEntity: state.detailCommicEntity,);
          }

          if(state is LoadingDetailState){
            return Scaffold(
              body: LoadingWidget(imageAsset: "assets/img/mascot/pic2.png"),
            );

          }
          return Container(
          );
        },
        listener: (context, state){}
    );
  }

}