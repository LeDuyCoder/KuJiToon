import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/core/theme/app_colors.dart';
import 'package:kujitoon/core/user/user_provider.dart';
import 'package:kujitoon/core/utils/responsive.dart';
import 'package:kujitoon/feature/home/bloc/home_bloc.dart';
import 'package:kujitoon/feature/home/bloc/home_state.dart';
import 'package:kujitoon/feature/home/view/website/pages/main_page.dart';
import 'package:kujitoon/feature/home/view/website/widgets/header_bar_widget.dart';
import 'package:kujitoon/feature/home/view/website/widgets/menu_widget.dart';
import 'package:kujitoon/feature/home/view/website/widgets/web/footer_widget.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage>{

  String PAGE = "HOME";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state){},
      builder: (context, state){
        if(state is LoadingHomeState){
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if(state is LoadedHomeState) {
          return Center(
            child: Scaffold(
              body: SizedBox.expand(
                child: Container(
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
                                      MenuWidget(page: PAGE, changePage: (page){
                                        setState(() {
                                          PAGE = page;
                                        });
                                      }),
                                      if(PAGE == "HOME")
                                        MainPage(context: context, state: state)
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

                ),
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
