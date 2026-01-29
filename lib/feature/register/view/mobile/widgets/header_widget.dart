import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 240,
      color: Colors.blue,
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(360),
                child: Container(
                  width: 70,
                  height: 70,
                  color: Colors.white.withAlpha(70),
                  child: Center(
                    child: Icon(Icons.menu_book, color: Colors.white, size: 40,),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Text("KUJITOON", style: TextStyle(fontFamily: "IrishGrover-Regular", fontSize: 40, color: Colors.white),)
            ],
          ),
          SizedBox(height: 20,),
          Text("Tạo tài khoản mới", style: TextStyle(fontFamily: "EncodeSans", fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
          Text("Tham gia cộng động yêu thích đọc truyện tranh", style: TextStyle(fontFamily: "EncodeSans", fontSize: 15, color: Colors.white.withAlpha(100), fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }

}