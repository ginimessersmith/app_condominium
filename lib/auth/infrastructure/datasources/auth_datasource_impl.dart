import 'package:condominium/auth/domain/domain.dart';
import 'package:condominium/auth/infrastructure/mappers/user.mapper.dart';
import 'package:condominium/config/constants/environment.dart';
import 'package:condominium/shared/shared.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
  ));
  @override
  Future<UserEntity> login(String email, String password) async {
    // TODO: implement login
    try {
      final response = await dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      // print(response);
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      print('error----------------------------------------------');
      print(e);
      if (e.response?.statusCode == 401) {
        print('credenciales no validas');
        throw CustomError('Credenciales Invalidas');
      }
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        print(e.response?.statusCode);
        throw CustomError('Tiempo de conexion agotado');
      }

      throw UnimplementedError();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserEntity> checkAuthStatus(String token) async {
    try {
      final response = await dio.get(
        '/auth/check-status',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError('Token no valido');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
