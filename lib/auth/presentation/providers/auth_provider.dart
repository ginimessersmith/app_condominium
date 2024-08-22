import 'package:condominium/auth/domain/domain.dart';
import 'package:condominium/auth/infrastructure/errors/auth_errors.dart';
import 'package:condominium/auth/infrastructure/infrastructure.dart';
import 'package:condominium/shared/services/key_value_store_service.dart';
import 'package:condominium/shared/services/key_value_store_service_impl.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
//? usar el key value sevices
  final keyValueStorageServices = KeyValueStorageServiceImpl();

  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageServices: keyValueStorageServices,
  );
});

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final UserEntity? user;
  final String errorMessage;

  AuthState({
    this.user,
    this.errorMessage = '',
    this.authStatus = AuthStatus.checking,
  });

  AuthState copyWith({
    UserEntity? user,
    String? errorMessage,
    AuthStatus? authStatus,
  }) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          user: user ?? this.user,
          errorMessage: errorMessage ?? this.errorMessage);
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageServices;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageServices,
  }) : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginUser(String email, String pass) async {
    try {
      final user = await authRepository.login(email, pass);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error no controlado');
    }
  }

  _setLoggedUser(UserEntity user) async {
    await keyValueStorageServices.setKeyValue('token', user.token);

    await keyValueStorageServices.setKeyValue('idUser', user.id);
    await keyValueStorageServices.setKeyValue('idRole', user.role.id);
    await keyValueStorageServices.setKeyValue('nameRole', user.role.name);
    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  Future<void> logout([String? errorMessage]) async {
    //todo limpiar token
    await keyValueStorageServices.removeKey('token');
    await keyValueStorageServices.removeKey('idUser');
    await keyValueStorageServices.removeKey('idRole');
    await keyValueStorageServices.removeKey('nameRole');

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }

  checkAuthStatus() async {
    final token = await keyValueStorageServices.getValue<String>('token');
    if (token == null) return logout();
    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }

  String? getUserRole() {
    return state.user?.role.name;
  }

  UserEntity? getUser() {
    return state.user;
  }
}
