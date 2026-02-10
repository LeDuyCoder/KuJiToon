import 'dart:convert';

import 'package:kujitoon/feature/shared_header/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderDatasource {
  Future<UserEntity> loadUserEntity() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> dataUser = jsonDecode(sharedPreferences.getString("user")!);

    return UserEntity(
        name: dataUser["name"],
        email: dataUser["email"],
        admin: dataUser["admin"],
        avatar: dataUser["avatar"],
        created_at: DateTime.fromMillisecondsSinceEpoch(dataUser["created_at"], isUtc: true)
            .toLocal()
    );
  }
}