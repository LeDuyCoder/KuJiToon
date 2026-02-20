import 'dart:convert';

class QueryCryptoUtil {
  /// 🔑 Salt để che dữ liệu (đổi tùy bạn)
  static const String _salt = 'KuJiTool@2026!';

  /// Encode Map -> String (đưa lên query)
  static String encode(Map<String, dynamic> data) {
    final jsonStr = jsonEncode(data);
    final salted = jsonStr + _salt;
    return base64UrlEncode(utf8.encode(salted));
  }

  /// Decode String -> Map (lấy từ query)
  static Map<String, dynamic> decode(String encoded) {
    final decoded = utf8.decode(base64Url.decode(encoded));
    final jsonStr = decoded.replaceAll(_salt, '');
    return jsonDecode(jsonStr) as Map<String, dynamic>;
  }
}