import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/core/theme/app_colors.dart';
import 'package:kujitoon/feature/home/bloc/home_bloc.dart';
import 'package:kujitoon/feature/home/bloc/home_event.dart';
import 'package:kujitoon/feature/home/bloc/home_state.dart';
import 'package:kujitoon/feature/home/view/website/pages/home_page.dart';
import 'package:kujitoon/feature/home/view/website/pages/mobile_main_page.dart';
import 'package:kujitoon/feature/home/view/website/widgets/mobile/footer_widget.dart';
import 'package:kujitoon/feature/home/view/website/widgets/mobile/grid_commic_widget.dart';
import 'package:kujitoon/feature/home/view/website/widgets/mobile/header_bar_widget.dart';
import 'package:kujitoon/feature/home/view/website/widgets/mobile/menu_widget.dart';
import 'package:kujitoon/feature/home/view/website/widgets/prominent_commic_widget.dart';
import 'package:kujitoon/feature/home/view/website/widgets/scroll_button.dart';

class MobileHomePage extends StatefulWidget{
  final LoadedHomeState state;
  bool isOpenMenu = false;

  MobileHomePage({super.key, required this.state});

  @override
  State<StatefulWidget> createState() => _MobileHomePage();

}

class _MobileHomePage extends State<MobileHomePage>{
  @override
  Widget build(BuildContext context) {

    var _widget = MediaQuery.sizeOf(context).width;
    var _hight = MediaQuery.sizeOf(context).height;

    return SizedBox(
      width: _widget,
      height: _hight,
      child: Stack(
        children: [
          if(HomePage.PAGE == "HOME")
            MainPage(state: widget.state),
          Column(
            children: [
              HeaderBarWidget(
                openMenu: (bool opened) {
                  setState(() {
                    widget.isOpenMenu = opened;
                  });
                }, isOpenMenu: widget.isOpenMenu,
              ),
              if(widget.isOpenMenu)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  height: widget.isOpenMenu ? 250 : 0,
                  child: ClipRect(
                    child: MenuWidget(changePage: (String page) {
                      setState(() {
                        HomePage.PAGE = page;
                      });
                    },),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }


}