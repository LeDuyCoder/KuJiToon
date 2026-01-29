import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/core/theme/app_colors.dart';
import 'package:kujitoon/core/user/user_provider.dart';
import 'package:kujitoon/core/utils/responsive.dart';
import 'package:kujitoon/feature/home/bloc/home_state.dart';
import 'package:kujitoon/feature/home/view/website/pages/home_page.dart';
import 'package:kujitoon/feature/home/view/website/pages/web_main_page.dart';
import 'package:kujitoon/feature/home/view/website/widgets/web/footer_widget.dart';
import 'package:kujitoon/feature/home/view/website/widgets/web/header_bar_widget.dart';
import 'package:kujitoon/feature/home/view/website/widgets/web/menu_widget.dart';

class WebHomePage extends StatefulWidget{
  final LoadedHomeState state;
  WebHomePage({super.key, required this.state});

  @override
  State<StatefulWidget> createState() => _WebHomePage();
}

class _WebHomePage extends State<WebHomePage>{


  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HeaderBarWidget(),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                          constraints: BoxConstraints(
                            maxWidth: Responsive.isDesktop(context)
                                ? 1200
                                : MediaQuery.sizeOf(context).width * 0.8,
                          ),
                          width: MediaQuery.sizeOf(context).width,
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
                                Text("Chào mừng trở lại, ${context.watch<UserProvider>().user?.name??"N/A"}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: AppColors.white, fontFamily: "EncodeSans"),),
                                Text("Khám phá thế giới truyện tranh đa dạng và tiếp tục hành trình đọc truyện của bạn.", style: TextStyle(fontSize: 15, color: AppColors.white, fontFamily: "EncodeSans"),)
                              ],
                            ),
                          )
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: Responsive.isDesktop(context)
                            ? 1200
                            : MediaQuery.sizeOf(context).width * 0.8,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10,),
                          MenuWidget(page: HomePage.PAGE, changePage: (page){
                            setState(() {
                              HomePage.PAGE = page;
                            });
                          }),
                          if(HomePage.PAGE == "HOME")
                            MainPage(context: context, state: widget.state)
                        ],
                      ),
                    ),
                    SizedBox(height: 50,),
                    FooterWidget()
                  ],
                ),
              ),
            ),
          ],
        )

    );
  }
}