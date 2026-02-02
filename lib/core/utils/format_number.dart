class FormatNumber {
  static String formatNumber(int number) {
    if (number < 1000) {
      return number.toString();
    } else if (number < 1000000) {
      double value = number / 1000;
      return '${value.toStringAsFixed(value % 1 == 0 ? 0 : 1)}K';
    } else if (number < 1000000000) {
      double value = number / 1000000;
      return '${value.toStringAsFixed(value % 1 == 0 ? 0 : 1)}M';
    } else {
      double value = number / 1000000000;
      return '${value.toStringAsFixed(value % 1 == 0 ? 0 : 1)}B';
    }
  }

}