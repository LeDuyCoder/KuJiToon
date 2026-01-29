import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget{
  final BorderRadiusGeometry borderRadiusGeometry;

  const HeaderWidget({super.key, required this.borderRadiusGeometry});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: borderRadiusGeometry
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Icon(Icons.menu_book, color: Colors.white, size: 80,),
          ),
          SizedBox(height: 20,),
          Text("Tham gia cùng chúng tôi", style: TextStyle(fontFamily: "EncodeSans", fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
          Text("Đăng ký tài khoản để bắt đầu hành trình khám phá thế giới truyện tranh không giới hạn.", style: TextStyle(fontFamily: "EncodeSans", fontSize: 15, color: Colors.white.withAlpha(100)), textAlign: TextAlign.center,)
        ],
      ),
    );
  }

}