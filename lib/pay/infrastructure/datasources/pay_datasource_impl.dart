import 'package:condominium/config/constants/environment.dart';
import 'package:condominium/pay/domain/datasources/pay_datasource.dart';
import 'package:condominium/pay/domain/entities/pay.entity.dart';
import 'package:condominium/pay/infrastructure/infrastructure_pay.dart';
import 'package:condominium/pay/infrastructure/mappers/payByOwner.mapper.dart';
import 'package:condominium/shared/shared.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';

class PayDatasourceImpl extends PayDatasource {
  late final Dio dio;
  final String accessToken;

  PayDatasourceImpl({required this.accessToken})
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
  Future<PayByOwner> payByOwner(int state) async {
    try {
      final response = await dio.get(
        '/condominium/pay/all-pay-by-owner/$state',
      );
      late PayByOwner payByOwner =
          PayByOwner.payByOwnerJsonToEntity(response.data);
      return payByOwner;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Tiempo de la conexion agotado');
      }
      if (e.response?.statusCode == 401) {
        throw CustomError('Usuario no autenticado');
      }
      if (e.response?.statusCode == 400) {
        throw CustomError('Estado del pago no encontrado');
      }
      throw UnimplementedError();
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<PayEntity> findOnePay(String id) async {
    try {
      final response = await dio.get(
        '/condominium/pay/$id',
      );
      PayEntity onePay = PayMapper.payJsonToEntity(response.data);
      return onePay;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Tiempo de la conexion agotado');
      }
      if (e.response?.statusCode == 404) CustomError('pago no encontrado');
      if (e.response?.statusCode == 401) CustomError('no autorizado');
      throw UnimplementedError();
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<bool> setStatePay(String id, String pathFile) async {
    try {
      // Crear una instancia de FormData
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          pathFile,
          filename: pathFile.split('/').last, // Nombre del archivo
          contentType: getMediaType(pathFile),
        ),
      });
      final response = await dio.patch(
        '/condominium/pay/pay-debit-file/$id',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      return true;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Tiempo de la conexion agotado');
      }
      if (e.response?.statusCode == 401) {
        throw CustomError('no autorizado');
      }
      if (e.response?.statusCode == 404) {
        throw CustomError('pago no encontrado');
      }
      if (e.response?.statusCode == 400) {
        throw CustomError('Bad request');
      }
      throw UnimplementedError();
    } catch (e) {
      throw UnimplementedError();
    }
  }

  MediaType getMediaType(String filePath) {
    final extension = path
        .extension(filePath)
        .toLowerCase(); // Obtén la extensión en minúsculas
    switch (extension) {
      case '.jpg':
      case '.jpeg':
        return MediaType('image', 'jpeg');
      case '.png':
        return MediaType('image', 'png');
      case '.gif':
        return MediaType('image', 'gif');
      case '.webp':
        return MediaType('image', 'webp');
      default:
        throw UnsupportedError('Formato de archivo no soportado: $extension');
    }
  }
}
