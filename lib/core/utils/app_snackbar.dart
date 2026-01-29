import 'package:flutter/material.dart';

class AppSnackBar {
  // Global key để quản lý ScaffoldMessenger toàn app
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
  GlobalKey<ScaffoldMessengerState>();

  // SnackBar thành công
  static void success(BuildContext context, String message) {
    messengerKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: Colors.white.withAlpha(0),
        elevation: 0,
        content: Container(
          width: MediaQuery.sizeOf(context).width * 0.5,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: Text(message, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  // SnackBar lỗi
  static void error(BuildContext context, String message) {
    messengerKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: Colors.white.withAlpha(0),
        elevation: 0,
        content: Container(
          width: MediaQuery.sizeOf(context).width * 0.5,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: Text(message, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  // SnackBar thông thường
  static void info(BuildContext context, String message) {
    messengerKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: Colors.white.withAlpha(0),
        elevation: 0,
        content: Container(
          width: MediaQuery.sizeOf(context).width * 0.5,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: Text(message, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  //================//====================//
}
