import 'package:flutter/material.dart';
import 'package:kujitoon/feature/search/domain/entities/prominent_commic.dart';

import '../comic_card.dart';

class ComicGrid extends StatelessWidget {
  final List<ProminentCommic> comics;
  final String userParagram;

  const ComicGrid({required this.comics, required this.userParagram});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int columnCount = constraints.maxWidth ~/ 200;
        columnCount = columnCount.clamp(4, 6);

        return GridView.builder(
          itemCount: comics.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            mainAxisSpacing: 20,
            crossAxisSpacing: 15,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            return ComicCard(comic: comics[index], userParagram: userParagram,);
          },
        );
      },
    );
  }
}