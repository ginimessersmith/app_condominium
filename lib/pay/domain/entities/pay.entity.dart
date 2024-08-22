class PayEntity {
    final String id;
    final String month;
    final int year;
    final bool isActive;
    final String payOfService;
    final String totalToPay;
    final String porcent;
    final String pantry;
    final String consummation;
    final int state;
    final bool reverse;
    final DateTime createAt;
    final DateTime updateAt;

    PayEntity({
        required this.id,
        required this.month,
        required this.year,
        required this.isActive,
        required this.payOfService,
        required this.totalToPay,
        required this.porcent,
        required this.pantry,
        required this.consummation,
        required this.state,
        required this.reverse,
        required this.createAt,
        required this.updateAt,
    });

    

    Map<String, dynamic> toJson() => {
        "id": id,
        "month": month,
        "year": year,
        "isActive": isActive,
        "pay_of_service": payOfService,
        "total_to_pay": totalToPay,
        "porcent": porcent,
        "pantry": pantry,
        "consummation": consummation,
        "state": state,
        "reverse": reverse,
        "create_at": createAt.toIso8601String(),
        "update_at": updateAt.toIso8601String(),
    };
}

