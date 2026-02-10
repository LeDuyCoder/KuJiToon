import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/feature/read/bloc/read_bloc.dart';
import 'package:kujitoon/feature/read/bloc/read_event.dart';
import 'package:kujitoon/feature/read/domain/entities/chapter_infomation_entity.dart';

class ChapterDropdown extends StatelessWidget {
  final ChapterInfomationEntity data;

  const ChapterDropdown(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: data.currentIndex,
          onChanged: (int? newIndex) {
            print(newIndex);
            if (newIndex == null) return;

            context.read<ReadBloc>().add(
              FeatchDataReadEvent(
                listChapters: data.listChapters,
                urlChapter:
                data.listChapters[newIndex].chapterApiData,
                detailComicEntity: data.detailCommicEntity,
                currentIndex: newIndex,
              ),
            );
          },
          items: List.generate(
            data.listChapters.length,
                (index) {
              final chapter = data.listChapters[index];
              return DropdownMenuItem<int>(
                value: index,
                child: Text('Chapter ${chapter.name}'),
              );
            },
          ),
        ),
      ),
    );
  }
}