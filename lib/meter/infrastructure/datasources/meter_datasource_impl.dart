import 'package:condominium/config/constants/environment.dart';
import 'package:condominium/meter/domain/datasources/meter_datasource.dart';
import 'package:condominium/meter/domain/entities/meter.entity.dart';
import 'package:condominium/meter/infrastructure/mappers/meter.mapper.dart';
import 'package:condominium/shared/errors/custom_error.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';

class MeterDatasourceImpl extends MeterDatasource {
  late final Dio dio;
  final String accessToken;

  MeterDatasourceImpl({required this.accessToken})
      : dio = Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 25),
            baseUrl: Environment.apiUrl,
            headers: {'Authorization': 'Bearer $accessToken'},
          ),
        );

  @override
  Future<List<MeterEntity>> findByCondominium(String id) async {
    try {
      final response =
          await dio.get('/condominium/meter/find-by-condominium/$id');
      List<MeterEntity> listMeter = [];
      for (var meterJson in response.data ?? []) {
        final MeterEntity meter = MeterMapper.meterJsonToEntity(meterJson);
        listMeter.add(meter);
      }
      return listMeter;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw CustomError('sin datos del condominio');
      }
      if (e.response?.statusCode == 404) {
        throw CustomError('no se encontraron datos');
      }
      if (e.response?.statusCode == 401) {
        throw CustomError('usuario no autorizado');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('El tiempo de espera se agoto');
      }
      throw UnimplementedError();
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<void> createMeter(Map<String, dynamic> data) async {
    try {
      FormData formData = FormData();
      // Iterar sobre el mapa para construir el FormData
      for (var key in data.keys) {
        if (key == 'file') {
          // Si la clave es 'file', asegúrate de procesarlo como un archivo
          var filePath = data[key];
          formData.files.add(MapEntry(
            key,
            await MultipartFile.fromFile(
              filePath,
              filename: path.basename(filePath),
              contentType:
                  getMediaType(filePath), // Cambia dinámicamente el tipo MIME
            ),
          ));
        } else {
          // Agregar otros campos como texto
          formData.fields.add(MapEntry(key, data[key].toString()));
        }
      }
      final response = await dio.post(
        '/condominium/meter/create-meter-file',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw CustomError('Error al crear la medición');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw CustomError('Datos inválidos');
      }
      if (e.response?.statusCode == 401) {
        throw CustomError('Usuario no autorizado');
      }
      if (e.response?.statusCode == 500) {
        throw CustomError('Error en el servidor');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('El tiempo de espera se agotó');
      }
      throw CustomError('Error desconocido al crear la medición');
    } catch (e) {
      throw CustomError('Ocurrió un error inesperado');
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
