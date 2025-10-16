import 'package:condominium/pay/domain/entities/pay.entity.dart';
import 'package:condominium/pay/infrastructure/mappers/payByOwner.mapper.dart';

abstract class PayRepository {
  Future<PayByOwner> payByOwner(int state);
  Future<bool> setStatePay(String id,String pathFile);
  Future<PayEntity> findOnePay(String id);
}
