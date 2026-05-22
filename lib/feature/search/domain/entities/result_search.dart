import 'package:kujitoon/feature/search/domain/entities/prominent_commic.dart';

class ResultSearch {
  final List<ProminentCommic> prominentComics;
  final int totalPage;
  final int currentPage;
  final int totalItem;

  ResultSearch({required this.prominentComics, required this.totalPage, required this.currentPage, required this.totalItem});
}