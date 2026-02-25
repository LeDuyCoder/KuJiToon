abstract class FollowComicEvent {}

class FeatchFollowComicByPageEvent extends FollowComicEvent {
  final int page;
  final int pageSize = 5;
  FeatchFollowComicByPageEvent(this.page);
}

class NextPageFollowComicEvent extends FollowComicEvent {
  final int page;
  NextPageFollowComicEvent(this.page);
}

