import 'package:kujitoon/feature/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({
    required super.email,
    required super.uuid,
  });

  factory UserModel.fromFirebaseUser(dynamic user){
    return UserModel(
        email: user["email"],
        uuid: user["uuid"],
    );
  }


}