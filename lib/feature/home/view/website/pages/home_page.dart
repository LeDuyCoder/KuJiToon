import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/core/utils/responsive.dart';
import 'package:kujitoon/feature/home/bloc/home_bloc.dart';
import 'package:kujitoon/feature/home/bloc/home_state.dart';
import 'package:kujitoon/feature/home/view/website/pages/mobile_home_page.dart';
import 'package:kujitoon/feature/home/view/website/pages/web_home_page.dart';
import 'package:kujitoon/feature/loading/view/widgets/loading_widget.dart';

class HomePage extends StatefulWidget{
  HomePage({super.key});

  static String PAGE = "HOME";

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state){},
      builder: (context, state){
        if(state is LoadingHomeState){
          return Scaffold(
            body: LoadingWidget(imageAsset: "assets/img/mascot/pic2.png"),
          );
        }

        if(state is LoadedHomeState) {
          return Center(
            child: Scaffold(
              body: SizedBox.expand(
                child: Responsive.isDesktop(context)
                    ? WebHomePage(state: state)
                    : MobileHomePage(state: state),
              ),
            ),
          );
        }

        else{
          return Center(
            child: Text("An error occurred"),
          );
        }
      },
    );
  }

}
