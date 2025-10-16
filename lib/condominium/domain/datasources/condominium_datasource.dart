import 'package:condominium/condominium/domain/domain_condominium.dart';

abstract class CondominiumDatasource {
  Future<List<CondominiumEntity>> findByOwner();
  Future<CondominiumEntity> getOneCondomminium(String id);
  Future<CondominiumEntity> findCondominiunByTechnical();
}
