import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kujitoon/core/theme/app_colors.dart';

class MenuWidget extends StatefulWidget {
  final String page;
  final void Function(String page) changePage;

  const MenuWidget({
    super.key,
    required this.page,
    required this.changePage,
  });

  @override
  State<MenuWidget> createState() => _MenuWidget();
}

class _MenuWidget extends State<MenuWidget> {

  bool isActive(String key) => widget.page == key;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 350,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(50),
            blurRadius: 5,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TITLE
            const Text(
              "Danh mục",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 6),
            const Divider(thickness: 1),
            const SizedBox(height: 10),

            /// TRANG CHỦ
            _menuItem(
              icon: Icons.home,
              title: "Trang Chủ",
              active: isActive("HOME"),
              onTap: () => widget.changePage("HOME"),
            ),

            /// THEO DÕI
            _menuItem(
              icon: Icons.bookmark,
              title: "Theo Dõi",
              active: isActive("FOLLOW"),
              onTap: () => widget.changePage("FOLLOW"),
            ),

            /// THỂ LOẠI
            _menuItem(
              icon: Icons.list,
              title: "Thể Loại",
              active: isActive("CATEGORY"),
              onTap: () => widget.changePage("CATEGORY"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required bool active,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: active ? Colors.blue.withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: active ? Colors.blue : Colors.black,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: active ? FontWeight.w600 : FontWeight.normal,
                color: active ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
