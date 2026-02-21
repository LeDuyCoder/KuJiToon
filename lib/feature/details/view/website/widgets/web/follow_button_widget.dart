import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/feature/details/domain/entities/detail_commic_entity.dart';
import 'package:kujitoon/feature/details/view/cubit/follow_button_cubit.dart';
import 'package:kujitoon/feature/details/view/cubit/follow_button_state.dart';

class FollowButtonWidget extends StatefulWidget {
  final DetailCommicEntity detailCommicEntity;

  const FollowButtonWidget({super.key, required this.detailCommicEntity});

  @override
  State<StatefulWidget> createState() => _FollowButtonWidget();
}

class _FollowButtonWidget extends State<FollowButtonWidget> {
  @override
  void initState() {
    super.initState();
    context.read<FollowButtonCubit>().checkFollow(widget.detailCommicEntity.slug);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowButtonCubit, FollowButtonState>(
      builder: (context, state){
        context.read<FollowButtonCubit>().checkFollow(widget.detailCommicEntity.slug);

        return SizedBox(
          width: 180,
          height: 44,
          child: ElevatedButton.icon(
            onPressed: () {
              if(state is FollowingButtonState){
                context.read<FollowButtonCubit>().unfollowComic(widget.detailCommicEntity.slug);
              } else {
                context.read<FollowButtonCubit>().followComic(widget.detailCommicEntity);
              }
            },
            icon: const Icon(Icons.bookmark_border, size: 20),
            label: Text(
              state is FollowingButtonState ? "Đang Theo Dõi" : "Theo Dõi",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEDEDED),
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
          ),
        );
      },
    );
  }
}