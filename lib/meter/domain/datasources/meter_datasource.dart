import 'package:condominium/meter/domain/entities/meter.entity.dart';

abstract class MeterDatasource {
  Future<List<MeterEntity>> findByCondominium(String id);
  Future<void> createMeter(Map<String, dynamic> data);
}
