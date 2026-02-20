import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kujitoon/core/routes/router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kujitoon/core/routes/fade_route.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late final StreamSubscription<User?> _sub;
  bool _handled = false;

  @override
  void initState() {
    super.initState();
    _sub = FirebaseAuth.instance
        .authStateChanges()
        .listen(_onAuthChanged);
  }

  Future<void> _onAuthChanged(User? user) async {
    if (!mounted || _handled) return;

    final prefs = await SharedPreferences.getInstance();
    final hasUserCache = prefs.containsKey('user');

    _handled = true;

    final targetRoute = hasUserCache ? '/home' : '/login';

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      FadeRoute(
        settings: RouteSettings(name: targetRoute),
        builder: AppRoutes.routes[targetRoute]!,
      ),
    );
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
