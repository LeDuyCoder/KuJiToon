abstract class SearchEvent {}

class FeatchDataSearchEvent implements SearchEvent{
  final String keyword;
  final int page;

  FeatchDataSearchEvent({required this.keyword, required this.page});
}