import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kujitoon/core/routes/fade_route.dart';
import 'package:kujitoon/router.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late final StreamSubscription<User?> _sub;

  @override
  void initState() {
    super.initState();
    _sub = FirebaseAuth.instance
        .authStateChanges()
        .listen(_onAuthChanged);
  }

  void _onAuthChanged(User? user) {
    if (!mounted) return;

    if (kIsWeb) {

      Navigator.pushReplacement(
        context,
        FadeRoute(
          settings: RouteSettings(name: user != null ? '/home' : '/login'),
          builder: routes[user != null ? '/home' : '/login']!, // 👈 lấy đúng route đã khai báo
        ),
      );
    }
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
