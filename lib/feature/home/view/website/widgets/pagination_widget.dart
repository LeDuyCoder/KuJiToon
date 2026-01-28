import 'package:flutter/material.dart';
import 'package:kujitoon/feature/home/view/website/widgets/hoverable_widget.dart';

class PaginationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  const PaginationWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final pages = _buildPages();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        _navButton(
          icon: Icons.chevron_left,
          enabled: currentPage > 1,
          onTap: () => onPageChanged(currentPage - 1),
        ),

        ...pages.map((p) {
          if (p == '...') {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Text('...'),
            );
          }
          final page = p as int;
          final isActive = page == currentPage;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: HoverableWidget(
              onTap: () => onPageChanged(page),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: isActive ? Colors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '$page',
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.black,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }),

        /// NEXT
        _navButton(
          icon: Icons.chevron_right,
          enabled: currentPage < totalPages,
          onTap: () => onPageChanged(currentPage + 1),
        ),
      ],
    );
  }

  Widget _navButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return IconButton(
      icon: Icon(icon),
      onPressed: enabled ? onTap : null,
    );
  }

  /// LOGIC PAGING
  List<dynamic> _buildPages() {
    final List<dynamic> pages = [];

    if (totalPages <= 5) {
      return List.generate(totalPages, (i) => i + 1);
    }

    pages.add(1);

    if (currentPage > 3) {
      pages.add('...');
    }

    final start = (currentPage - 1).clamp(2, totalPages - 1);
    final end = (currentPage + 1).clamp(2, totalPages - 1);

    for (int i = start; i <= end; i++) {
      pages.add(i);
    }

    if (currentPage < totalPages - 2) {
      pages.add('...');
    }

    pages.add(totalPages);

    return pages;
  }
}
