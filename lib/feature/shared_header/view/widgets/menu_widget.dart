import 'package:flutter/material.dart';
import 'package:kujitoon/core/theme/app_colors.dart';
import 'package:kujitoon/feature/home/view/website/pages/home_page.dart';
import 'package:kujitoon/feature/shared_header/domain/entities/user_entity.dart';


class MenuWidget extends StatelessWidget{
  final UserEntity userEntity;

  const MenuWidget({super.key, required this.userEntity});

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
                    userEntity.name,
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
          Column(
            children: [
              _menuItem(
                icon: Icons.home_rounded,
                title: 'Trang chủ',
                onTap: (){
                  HomePage.PAGE = "HOME";
                  Navigator.pushReplacementNamed(context, "/home");
                },
              ),
              _menuItem(
                icon: Icons.bookmark,
                title: 'Theo Dỗi',
                onTap: (){

                },
              ),
              _menuItem(
                icon: Icons.list,
                title: 'Thể Loại',
                onTap: (){},
              ),
            ],
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
