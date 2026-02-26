import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kujitoon/core/theme/app_colors.dart';
import 'package:kujitoon/feature/details/domain/entities/user_entity.dart';

class MenuWidget extends StatelessWidget{
  final void Function(String page) changePage;
  final Map<String, String> userEntity;
  final UserEntity user;

  MenuWidget({super.key, required this.changePage, required this.userEntity}):
        user = UserEntity.fromQueryParams(userEntity);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primary,
        border: Border(top: BorderSide(color: AppColors.white, width: 2)),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== HEADER =====
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.white.withOpacity(0.2),
                child: Icon(
                  Icons.person,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Xin chào 👋',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    user.name,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),
          Divider(color: AppColors.white.withOpacity(0.3)),

          // ===== MENU ITEMS =====
          Expanded(
            child: Column(
              children: [
                _menuItem(
                  icon: Icons.home_rounded,
                  title: 'Trang chủ',
                  onTap: () => changePage("HOME"),
                ),
                _menuItem(
                  icon: Icons.bookmark,
                  title: 'Theo Dỗi',
                  onTap: () => changePage("FOLLOW"),
                ),
                _menuItem(
                  icon: Icons.list,
                  title: 'Thể Loại',
                  onTap: () => changePage("CATEGORY"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _menuItem({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(8),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: AppColors.white),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
    ),
  );
}
