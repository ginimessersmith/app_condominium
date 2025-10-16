import 'package:condominium/condominium/domain/entities/condominium.entity.dart';

abstract class CondominiumRepository {
  Future<List<CondominiumEntity>> findByOwner();
  Future<CondominiumEntity> getOneCondomminium(String id);
  Future<CondominiumEntity> findCondominiunByTechnical();
}
