// To parse this JSON data, do
//
//     final condominiumEntity = condominiumEntityFromJson(jsonString);

import 'package:condominium/auth/domain/domain.dart';
import 'package:condominium/department/domain/domain_department.dart';
import 'package:condominium/pay/domain/domain_pay.dart';
import '../../../payment/domain/domain_payment.dart';

class CondominiumEntity {
  final String id;
  final String name;
  final String address;
  final String latitude;
  final String longitude;
  final String pantry;
  final String image;
  final String meterNumber;
  final bool isActive;
  final int numberOfApartments;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<TechnicalEntity>? technical;
  final ManagerEntity? manager;
  final List<DepartmentEntity>? department;

  CondominiumEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.pantry,
    required this.image,
    required this.meterNumber,
    required this.isActive,
    required this.numberOfApartments,
    required this.createdAt,
    required this.updatedAt,
    required this.technical,
    required this.manager,
    required this.department,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "pantry": pantry,
        "image": image,
        "meter_number": meterNumber,
        "isActive": isActive,
        "number_of_apartments": numberOfApartments,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        // "technical": List<dynamic>.from(technical.map((x) => x.toJson())),
        // "owner": List<dynamic>.from(owner.map((x) => x)),
        // "payment": List<dynamic>.from(payment.map((x) => x.toJson())),
        // "department": List<dynamic>.from(department.map((x) => x.toJson())),
        // "pay": List<dynamic>.from(pay.map((x) => x.toJson())),
        // "manager": manager.toJson(),
      };
}
