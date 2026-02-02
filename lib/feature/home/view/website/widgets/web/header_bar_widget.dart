import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/core/theme/app_colors.dart';
import 'package:kujitoon/core/user/user_provider.dart';
import 'package:kujitoon/core/utils/responsive.dart';

class HeaderBarWidget extends StatelessWidget{
  const HeaderBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 100,
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: Responsive.isDesktop(context)
                  ? 1200
                  : MediaQuery.sizeOf(context).width * 0.8,
            ),
            child: Row(
              children: [
                SizedBox(width: 10,),
                Row(
                  children: [
                    Icon(Icons.menu_book, color: AppColors.white, size: 35,),
                    SizedBox(width: 8,),
                    Text("Kujitoon", style: TextStyle(
                        color: AppColors.white,
                        fontSize: 30,
                        fontFamily: "IrishGrover-Regular"
                    ),)
                  ],
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 35,
                    decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10,),
                        Icon(Icons.search, color: Colors.black54, size: 20,),
                        SizedBox(width: 10,),
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "Tìm kiếm truyện tranh...",
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 12, fontFamily: "EncodeSans"),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Row(
                  children: [
                    Icon(Icons.account_circle, color: AppColors.white, size: 35,),
                    SizedBox(width: 2,),
                    Text(context.watch<UserProvider>().user?.name??"N/A", style: TextStyle(fontFamily: "EncodeSans", color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                    SizedBox(width: 20)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}