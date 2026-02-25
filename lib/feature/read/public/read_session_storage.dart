import 'dart:convert';
import 'dart:html' as html;
import 'package:kujitoon/feature/read/public/read_session_payload.dart';

class ReadSessionStorage {
  static const _key = 'READ_PAYLOAD';

  static void save(ReadSessionPayload payload) {
    html.window.sessionStorage[_key] = jsonEncode(payload.toJson());
  }

  static ReadSessionPayload? load() {
    final raw = html.window.sessionStorage[_key];
    if (raw == null) return null;

    return ReadSessionPayload.fromJson(jsonDecode(raw));
  }

  static void clear() {
    html.window.sessionStorage.remove(_key);
  }
}
