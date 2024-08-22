class PaymentEntity {
    final String id;
    final String month;
    final String cubicMeterConsumption;
    final String totalAmount;
    final String? filePayment;
    final bool isActive;
    final DateTime? paymentDate;
    final DateTime dateIssue;
    final DateTime dateCutoff;
    final int state;
    final int year;
    final DateTime createdAt;
    final DateTime updatedAt;

    PaymentEntity({
        required this.id,
        required this.month,
        required this.cubicMeterConsumption,
        required this.totalAmount,
        required this.filePayment,
        required this.isActive,
        required this.paymentDate,
        required this.dateIssue,
        required this.dateCutoff,
        required this.state,
        required this.year,
        required this.createdAt,
        required this.updatedAt,
    });

    

    Map<String, dynamic> toJson() => {
        "id": id,
        "month": month,
        "cubic_meter_consumption": cubicMeterConsumption,
        "total_amount": totalAmount,
        "file_payment": filePayment,
        "isActive": isActive,
        "payment_date": "${paymentDate!.year.toString().padLeft(4, '0')}-${paymentDate!.month.toString().padLeft(2, '0')}-${paymentDate!.day.toString().padLeft(2, '0')}",
        "date_issue": "${dateIssue.year.toString().padLeft(4, '0')}-${dateIssue.month.toString().padLeft(2, '0')}-${dateIssue.day.toString().padLeft(2, '0')}",
        "date_cutoff": "${dateCutoff.year.toString().padLeft(4, '0')}-${dateCutoff.month.toString().padLeft(2, '0')}-${dateCutoff.day.toString().padLeft(2, '0')}",
        "state": state,
        "year": year,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}