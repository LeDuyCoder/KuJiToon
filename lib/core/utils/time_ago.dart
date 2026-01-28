class TimeAgo {
  static String time(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inSeconds < 60) {
      return 'Vừa xong';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} phút trước';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} giờ trước';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} ngày trước';
    } else if (diff.inDays < 30) {
      return '${(diff.inDays / 7).floor()} tuần trước';
    } else if (diff.inDays < 365) {
      return '${(diff.inDays / 30).floor()} tháng trước';
    } else {
      return '${(diff.inDays / 365).floor()} năm trước';
    }
  }

}