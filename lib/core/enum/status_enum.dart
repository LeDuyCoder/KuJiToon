enum StatusEnum {
  ongoing,
  completed,
  pending,
}

extension StatusEnumExt on StatusEnum {
  /// Giá trị gửi lên / nhận từ API
  String get value {
    switch (this) {
      case StatusEnum.ongoing:
        return 'ongoing';
      case StatusEnum.completed:
        return 'completed';
      case StatusEnum.pending:
        return 'pending';
    }
  }

  /// Text hiển thị cho user
  String get label {
    switch (this) {
      case StatusEnum.ongoing:
        return 'Đang ra';
      case StatusEnum.completed:
        return 'Hoàn thành';
      case StatusEnum.pending:
        return 'Tạm dừng';
    }
  }

  /// Parse từ string (API) -> enum
  static StatusEnum fromValue(String? value) {
    return StatusEnum.values.firstWhere(
          (e) => e.value == value,
      orElse: () => StatusEnum.pending,
    );
  }
}

