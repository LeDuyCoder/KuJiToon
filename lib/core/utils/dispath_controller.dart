import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kujitoon/core/utils/app_snackbar.dart';
import 'package:kujitoon/router.dart';

class DispathController {
  DispathController._privateConstructor();

  static final DispathController _instance =
      DispathController._privateConstructor();

  factory DispathController() {
    return _instance;
  }

  MaterialApp dispatch(GlobalKey<NavigatorState> navigatorKey) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String page = "/splash";


    if (kIsWeb) {
      page = "/authGate";
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: AppSnackBar.messengerKey,
        title: 'KuJiToon',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)),
        initialRoute: page,
        routes: routes
    );
  }
}