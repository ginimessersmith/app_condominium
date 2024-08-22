import 'package:condominium/payment/domain/entities/payment.entity.dart';

class PaymentMapper {
  static PaymentEntity paymentJsonToEntity(Map<String, dynamic> json) =>
      PaymentEntity(
        id: json["id"],
        month: json["month"],
        cubicMeterConsumption: json["cubic_meter_consumption"],
        totalAmount: json["total_amount"],
        filePayment: json["file_payment"],
        isActive: json["isActive"],
        paymentDate: json["payment_date"] == null
            ? null
            : DateTime.parse(json["payment_date"]),
        dateIssue: DateTime.parse(json["date_issue"]),
        dateCutoff: DateTime.parse(json["date_cutoff"]),
        state: json["state"],
        year: json["year"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
