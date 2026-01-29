import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  FadeRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) : super(
    settings: settings,
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (context, animation, secondaryAnimation) {
      return builder(context);
    },
    transitionsBuilder:
        (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
