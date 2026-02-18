import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kujitoon/core/theme/app_colors.dart';
import 'package:kujitoon/feature/home/view/website/widgets/hoverable_widget.dart';
import 'package:kujitoon/feature/shared_header/domain/entities/user_entity.dart';

class MobileHeaderWidget extends StatefulWidget {
  final bool isOpenMenu;
  final void Function(bool opened) openMenu;
  final UserEntity userEntity;

  const MobileHeaderWidget({
    super.key,
    required this.isOpenMenu,
    required this.openMenu,
    required this.userEntity,
  });

  @override
  State<StatefulWidget> createState() => _MobileHeaderWidget();
}

class _MobileHeaderWidget extends State<MobileHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 100,
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Row(
              children: [
                SizedBox(width: 10),
                HoverableWidget(
                  onTap: () {
                    Navigator.pushNamed(context, "/home");
                  },
                  child: Row(
                    children: [
                      Icon(Icons.menu_book, color: AppColors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "Kujitoon",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 25,
                          fontFamily: "IrishGrover-Regular",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.search, color: Colors.black54, size: 20),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "Tìm kiếm truyện tranh...",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontFamily: "EncodeSans",
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: HoverableWidget(
                    onTap: () {
                      widget.openMenu(!widget.isOpenMenu);
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) {
                        return RotationTransition(
                          turns: animation,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: Icon(
                        widget.isOpenMenu
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.menu,
                        key: ValueKey(widget.isOpenMenu),
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
