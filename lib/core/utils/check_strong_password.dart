class CheckStrongPassword {
  static double check(String password) {
    double score = 0.0;

    final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    final hasDigit = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecial = RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password);
    final hasMinLength = password.length >= 8;

    if (hasLowercase) score += 0.2;
    if (hasUppercase) score += 0.2;
    if (hasDigit) score += 0.2;
    if (hasSpecial) score += 0.2;
    if (hasMinLength) score += 0.2;

    return score;
  }
}