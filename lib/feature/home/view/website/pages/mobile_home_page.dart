import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kujitoon/feature/home/bloc/home_state.dart';
import 'package:kujitoon/feature/home/view/website/pages/home_page.dart';
import 'package:kujitoon/feature/home/view/website/pages/mobile_main_page.dart';
import 'package:kujitoon/feature/shared_header/view/widgets/header_widget.dart';

class MobileHomePage extends StatefulWidget {
  final LoadedHomeState state;
  bool isOpenMenu = false;

  MobileHomePage({super.key, required this.state});

  @override
  State<StatefulWidget> createState() => _MobileHomePage();
}

class _MobileHomePage extends State<MobileHomePage> {
  @override
  Widget build(BuildContext context) {
    var _widget = MediaQuery.sizeOf(context).width;
    var _hight = MediaQuery.sizeOf(context).height;

    return SizedBox(
      width: _widget,
      height: _hight,
      child: Stack(
        children: [
          MainPage(state: widget.state),
          Column(
            children: [
              HeaderWidget(
                isOpeneMenu: widget.isOpenMenu,
                openMenu: (opened) {
                  setState(() {
                    widget.isOpenMenu = opened;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
