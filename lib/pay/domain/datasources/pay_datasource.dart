import 'package:condominium/pay/domain/domain_pay.dart';
import 'package:condominium/pay/infrastructure/mappers/payByOwner.mapper.dart';

abstract class PayDatasource {
  Future<PayByOwner> payByOwner(int state);
  Future<bool> setStatePay(String id,String path_file);
  Future<PayEntity> findOnePay(String id);
}
