abstract class DetailEvent {}

class FetchDataDetailEvent implements DetailEvent{
  final String slug;

  FetchDataDetailEvent({required this.slug});
}