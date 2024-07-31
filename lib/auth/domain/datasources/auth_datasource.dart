import 'package:condominium/auth/domain/entities/user.entity.dart';

abstract class AuthDatasource {

  Future<UserEntity> login(String email, String password);
  
}
