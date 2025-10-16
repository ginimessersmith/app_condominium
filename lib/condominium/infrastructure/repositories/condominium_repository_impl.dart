import 'package:condominium/condominium/domain/domain_condominium.dart';

class CondominiumRepositoryImpl extends CondominiumRepository {
  final CondominiumDatasource datasource;

  CondominiumRepositoryImpl({required this.datasource});

  @override
  Future<List<CondominiumEntity>> findByOwner() {
    // TODO: implement findByOwner
    return datasource.findByOwner();
  }

  @override
  Future<CondominiumEntity> getOneCondomminium(String id) {
    // TODO: implement getOneCondomminium
    return datasource.getOneCondomminium(id);
  }

  @override
  Future<CondominiumEntity> findCondominiunByTechnical() {
    return datasource.findCondominiunByTechnical();
  }
}
