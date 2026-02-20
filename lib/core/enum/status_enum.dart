enum StatusEnum {
  ongoing,
  completed,
  pending,
}

extension StatusEnumX on StatusEnum {
  String toJson() => name;

  static StatusEnum fromJson(String value) =>
      StatusEnum.values.firstWhere(
            (e) => e.name == value,
      );
}

extension StatusEnumExt on StatusEnum {
  /// Giá trị gửi lên / nhận từ API
  String get value {
    switch (this) {
      case StatusEnum.ongoing:
        return 'Đang Cập Nhật';
      case StatusEnum.completed:
        return 'Hoàn Thành';
      case StatusEnum.pending:
        return 'Đang Cập Nhật';
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

