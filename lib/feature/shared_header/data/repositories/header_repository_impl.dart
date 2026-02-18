import 'package:kujitoon/feature/shared_header/data/datasource/header_datasource.dart';
import 'package:kujitoon/feature/shared_header/domain/entities/user_entity.dart';
import 'package:kujitoon/feature/shared_header/domain/repositories/header_repository.dart';

class HeaderRepositoryImpl implements HeaderRepository{
  final HeaderDatasource datasource;

  HeaderRepositoryImpl({required this.datasource});

  @override
  Future<UserEntity> loadUserEntity() {
    return datasource.loadUserEntity();
  }
}