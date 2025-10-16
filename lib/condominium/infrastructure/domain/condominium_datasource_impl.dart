import 'package:condominium/condominium/domain/domain_condominium.dart';
import 'package:condominium/condominium/infrastructure/mappers/condominium.mapper.dart';
import 'package:condominium/config/constants/environment.dart';
import 'package:condominium/shared/errors/custom_error.dart';
import 'package:dio/dio.dart';

class CondominiumDatasourceImpl extends CondominiumDatasource {
  late final Dio dio;
  final String accessToken;
  CondominiumDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
            baseUrl: Environment.apiUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 25),
            headers: {'Authorization': 'Bearer $accessToken'}));
  @override
  Future<List<CondominiumEntity>> findByOwner() async {
    try {
      final response = await dio.get(
        '/condominium/find-by-owner',
      );
      final List<CondominiumEntity> listCondominium = [];

      for (final condominiumJson in response.data ?? []) {
        listCondominium
            .add(CondominiumMapper.condominiumJsonToEntity(condominiumJson));
      }
      return listCondominium;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Tiempo de conexión agotado');
      } else if (e.response?.statusCode == 404) {
        throw CustomError('No se encontraron condominios para el propietario');
      } else {
        print(e.message);
        throw CustomError('Error en la solicitud: ${e.message}');
      }
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<CondominiumEntity> getOneCondomminium(String id) {
    // TODO: implement getOneCondomminium
    throw UnimplementedError();
  }

  @override
  Future<CondominiumEntity> findCondominiunByTechnical() async {
    try {
      final response = await dio.get(
        '/condominium/find-by-technical',
      );
      final CondominiumEntity condominiumTechnical =
          CondominiumMapper.condominiumJsonToEntity(response.data);
      return condominiumTechnical;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Tiempo agotado');
      }
      if (e.response?.statusCode == 404) {
        throw CustomError('Sin condominio');
      } else {
        throw UnimplementedError(e.message);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
