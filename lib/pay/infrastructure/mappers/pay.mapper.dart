

import 'package:condominium/pay/domain/entities/pay.entity.dart';

class PayMapper {
  static PayEntity payJsonToEntity(Map<String, dynamic> json) => PayEntity(
        id: json["id"],
        month: json["month"],
        year: json["year"],
        isActive: json["isActive"],
        payOfService: json["pay_of_service"],
        totalToPay: json["total_to_pay"],
        porcent: json["porcent"],
        pantry: json["pantry"],
        consummation: json["consummation"],
        state: json["state"],
        reverse: json["reverse"],
        createAt: DateTime.parse(json["create_at"]),
        updateAt: DateTime.parse(json["update_at"]),
    );
}
