import 'package:flutter/material.dart';

class ScrollButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const ScrollButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.white.withOpacity(0.8),
        shape: const CircleBorder(),
        elevation: 3,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(icon, size: 30),
          ),
        ),
      ),
    );
  }
}