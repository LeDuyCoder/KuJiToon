import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/core/utils/responsive.dart';
import 'package:kujitoon/feature/loading/view/widgets/loading_widget.dart';
import 'package:kujitoon/feature/read/bloc/read_bloc.dart';
import 'package:kujitoon/feature/read/bloc/read_state.dart';
import 'package:kujitoon/feature/read/view/website/pages/mobile/mobile_read_page.dart';
import 'package:kujitoon/feature/read/view/website/pages/web/web_read_page.dart';

class ReadPage extends StatelessWidget{
  const ReadPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReadBloc, ReadState>(
        builder: (context, state){
          if(state is LoadedReadState){
            return Scaffold(
              body: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                child: Responsive.isDesktop(context)
                    ? WebReadPage(chapterInfomationEntity: state.chapterInfomationEntity,)
                    : MobileReadPage(chapterInfomationEntity: state.chapterInfomationEntity)
              ),
            );
          }
          
          if(state is ErrorReadState){
            return Scaffold(
              body: Text(state.msg),
            );
          }

          return Scaffold(
            body: Center(
              child: LoadingWidget(imageAsset: "assets/img/mascot/pic2.png"),
            ),
          );
        },
        listener: (context, state){}
    );
  }

}