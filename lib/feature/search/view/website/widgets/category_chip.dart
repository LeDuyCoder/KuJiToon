import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;

  const CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: Colors.blue,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}