
import 'package:condominium/pay/domain/domain_pay.dart';
import 'package:condominium/pay/infrastructure/infrastructure_pay.dart';

class PayByOwner {
    final double total;
    final List<PayEntity> listPay;

    PayByOwner({
        required this.total,
        required this.listPay,
    });

    static PayByOwner payByOwnerJsonToEntity(Map<String, dynamic> json) => PayByOwner(
        total: json["total"]?.toDouble(),
        listPay: List<PayEntity>.from(json["listPay"].map((x) => PayMapper.payJsonToEntity(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "listPay": List<dynamic>.from(listPay.map((x) => x.toJson())),
    };
}
