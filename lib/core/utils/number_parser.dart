class NumberParser {
  const NumberParser._();

  static int toInt(
      dynamic value, {
        int defaultValue = 0,
      }) {
    if (value == null) return defaultValue;

    if (value is int) return value;
    if (value is double) return value.toInt();

    if (value is String) {
      final normalized = value.trim();
      return int.tryParse(normalized) ?? defaultValue;
    }

    return defaultValue;
  }

  static double toDouble(
      dynamic value, {
        double defaultValue = 0.0,
      }) {
    if (value == null) return defaultValue;

    if (value is double) return value;
    if (value is int) return value.toDouble();

    if (value is String) {
      final normalized = value
          .trim()
          .replaceAll(',', '.');

      return double.tryParse(normalized) ?? defaultValue;
    }

    return defaultValue;
  }

  static double toFloat(
      dynamic value, {
        double defaultValue = 0.0,
      }) {
    return toDouble(value, defaultValue: defaultValue);
  }
}
