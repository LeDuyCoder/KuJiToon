import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoFollowWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 350,
        margin: EdgeInsets.only(left: 30),
        width: MediaQuery.sizeOf(context).width * 0.8,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 15
              )
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/img/mascot/pic4.png", width: 200, height: 200),
            Text("Chưa có truyện nào được theo dõi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),)
          ],
        ),
      ),
    );
  }

}