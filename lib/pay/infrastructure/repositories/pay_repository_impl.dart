import 'package:condominium/pay/domain/datasources/pay_datasource.dart';
import 'package:condominium/pay/domain/entities/pay.entity.dart';
import 'package:condominium/pay/domain/repositories/pay_repository.dart';
import 'package:condominium/pay/infrastructure/mappers/payByOwner.mapper.dart';

class PayRepositoryImpl extends PayRepository {
  final PayDatasource datasource;

  PayRepositoryImpl({required this.datasource});
  @override
  Future<PayByOwner> payByOwner(int state) {
    return datasource.payByOwner(state);
  }

  @override
  Future<PayEntity> findOnePay(String id) {
    // TODO: implement findOnePay
    return datasource.findOnePay(id);
  }

  @override
  Future<bool> setStatePay(String id,String pathFile) {
    // TODO: implement setStatePay
    return datasource.setStatePay(id,pathFile);
  }
}
