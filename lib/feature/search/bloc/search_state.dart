import 'package:kujitoon/feature/search/domain/entities/result_search.dart';

abstract class SearchState{}

class SearchLoadingState extends SearchState{}

class SearchLoadedState extends SearchState{
  final ResultSearch resultSearch;
  final String keyword;
  final String userParagram;

  SearchLoadedState({required this.resultSearch, required this.keyword, required this.userParagram});
}

class SearchNotFoundState extends SearchState{}