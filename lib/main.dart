import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:kujitoon/feature/splash/view/splash_screen.dart';
import 'package:kujitoon/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const KuJiToonApp(),
    );
  }
}

class KuJiToonApp extends StatelessWidget{
  const KuJiToonApp({super.key});

  @override
  Widget build(BuildContext context) {

    Widget initialScreen;

    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) {
      initialScreen = SplashScreen();
    } else {
      // Android/iOS → show SplashScreen
      initialScreen = SplashScreen();
    }

    return MaterialApp(
      title: 'KuJiToon',
      home: initialScreen,
      routes: {
      },
    );
  }
}
