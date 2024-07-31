import 'package:condominium/auth/domain/entities/user.entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
}
