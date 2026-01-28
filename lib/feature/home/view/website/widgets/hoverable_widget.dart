import 'package:flutter/material.dart';

class HoverableWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final MouseCursor cursor;
  final Duration duration;
  final double hoverScale;

  const HoverableWidget({
    super.key,
    required this.child,
    this.onTap,
    this.cursor = SystemMouseCursors.click,
    this.duration = const Duration(milliseconds: 150),
    this.hoverScale = 1.05,
  });

  @override
  State<HoverableWidget> createState() => _HoverableWidgetState();
}

class _HoverableWidgetState extends State<HoverableWidget> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.cursor,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hover ? widget.hoverScale : 1.0,
          duration: widget.duration,
          child: widget.child,
        ),
      ),
    );
  }
}
