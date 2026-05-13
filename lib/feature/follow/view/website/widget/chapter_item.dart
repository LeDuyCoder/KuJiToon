import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChapterItem extends StatefulWidget {
  final String title;
  final String time;
  final bool isRead;
  final VoidCallback? onTap;

  const ChapterItem({
    super.key,
    required this.title,
    required this.time,
    required this.isRead,
    this.onTap,
  });

  @override
  State<ChapterItem> createState() => _ChapterItemState();
}

class _ChapterItemState extends State<ChapterItem> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    final Color textColor =
    widget.isRead ? Colors.grey : Colors.black;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHover = true),
      onExit: (_) => setState(() => _isHover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Chapter ${widget.title}",
                style: TextStyle(
                  fontSize: 13,
                  color: textColor,
                  decoration: _isHover
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
              ),
              Text(
                widget.time,
                style: TextStyle(
                  fontSize: 12,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}