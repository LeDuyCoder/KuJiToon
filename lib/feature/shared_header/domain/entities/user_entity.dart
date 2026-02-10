class UserEntity {
  final String name;
  final String email;
  final bool admin;
  final String avatar;
  final DateTime created_at;

  UserEntity({required this.name, required this.email, required this.admin, required this.avatar, required this.created_at});

}