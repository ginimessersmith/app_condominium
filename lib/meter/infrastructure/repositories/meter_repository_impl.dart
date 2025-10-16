import 'package:condominium/meter/domain/datasources/meter_datasource.dart';
import 'package:condominium/meter/domain/entities/meter.entity.dart';
import 'package:condominium/meter/domain/repositories/meter_repository.dart';

class MeterRepositoryImpl extends MeterRepository {
  final MeterDatasource datasource;

  MeterRepositoryImpl({required this.datasource});

  @override
  Future<List<MeterEntity>> findByCondominium(String id) {
    return datasource.findByCondominium(id);
  }

  @override
  Future<void> createMeter(Map<String, dynamic> data) {
    return datasource.createMeter(data);
  }
}
