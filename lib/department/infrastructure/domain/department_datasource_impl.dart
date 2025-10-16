import 'package:condominium/config/constants/environment.dart';
import 'package:condominium/department/domain/datasource/department_datasource.dart';
import 'package:condominium/department/domain/entities/department.entity.dart';
import 'package:condominium/department/infrastructure/infrastructure_department.dart';
import 'package:condominium/shared/shared.dart';
import 'package:dio/dio.dart';

class DepartmentDatasourceImpl extends DepartmentDatasource {
  late final Dio dio;
  final String accessToken;

  DepartmentDatasourceImpl({required this.accessToken})
      : dio = Dio(
          BaseOptions(
              baseUrl: Environment.apiUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 15),
              headers: {
                'Authorization': 'Bearer $accessToken',
              }),
        );

  @override
  Future<List<DepartmentEntity>> listDepartmentByUser() async {
    // TODO: implement listDepartmentByUser
    try {
      final response = await dio.get('/condominium/department/find-by-owner');
      final List<DepartmentEntity> listDep = [];
      for (final departmentJson in response.data ?? []) {
        listDep.add(DepartmentMapper.departmentJsonToEntity(departmentJson));
      }
      return listDep;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Tiempo de conexión agotado');
      } else if (e.response?.statusCode == 401) {
        throw CustomError(
            'No se encontraron departamentos para el propietario');
      } else {
        throw CustomError('Error en la solicitud: ${e.message}');
      }
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<DepartmentEntity> findOneDepartment(String id) async {
    try {
      final response =
          await dio.get('/condominium/department/find-one-department/$id');
      final DepartmentEntity department =
          DepartmentMapper.departmentJsonToEntity(response.data);
      return department;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404)
        CustomError('No se encontro del departamento');
      throw UnimplementedError(e.message);
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
