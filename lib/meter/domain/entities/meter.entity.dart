import 'package:condominium/department/domain/domain_department.dart';

class MeterEntity {
  final String id;
  final String month;
  final bool isActive;
  final int state;
  final int year;
  final String consummation;
  final String? imgUrl;
  final DateTime createAt;
  final DateTime updateAt;
  final DepartmentEntity? department;

  MeterEntity({
    required this.id,
    required this.month,
    required this.isActive,
    required this.state,
    required this.year,
    required this.consummation,
    required this.imgUrl,
    required this.createAt,
    required this.updateAt,
    required this.department,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "month": month,
        "isActive": isActive,
        "state": state,
        "year": year,
        "consummation": consummation,
        "img_url": imgUrl,
        "create_at": createAt.toIso8601String(),
        "update_at": updateAt.toIso8601String(),
        "department": department
      };

  Map<String, dynamic> toCreateMeasurementJson() => {
        "month": month,
        "consummation": consummation,
        "year": year,
        "department_id": department?.id,
      };
}
