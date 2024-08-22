import 'package:condominium/auth/domain/domain.dart';
import 'package:condominium/auth/infrastructure/datasources/auth_datasource_impl.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl({AuthDatasource? datasource})
      : datasource = datasource ?? AuthDatasourceImpl();
  @override
  Future<UserEntity> login(String email, String password) {
    // TODO: implement login
    return datasource.login(email, password);
  }

  @override
  Future<UserEntity> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    return datasource.checkAuthStatus(token);
  }
}
