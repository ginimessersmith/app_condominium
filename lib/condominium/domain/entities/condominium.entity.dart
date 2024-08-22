// To parse this JSON data, do
//
//     final condominiumEntity = condominiumEntityFromJson(jsonString);

import 'dart:convert';

import 'package:condominium/auth/domain/domain.dart';
import 'package:condominium/auth/infrastructure/infrastructure.dart';
import 'package:condominium/department/domain/domain_department.dart';
import 'package:condominium/department/infrastructure/infrastructure_department.dart';
import 'package:condominium/pay/domain/domain_pay.dart';
import 'package:condominium/pay/infrastructure/infrastructure_pay.dart';
import 'package:condominium/payment/infrastructure/mappers/payment.mapper.dart';

import '../../../payment/domain/domain_payment.dart';


List<CondominiumEntity> condominiumEntityFromJson(String str) => List<CondominiumEntity>.from(json.decode(str).map((x) => CondominiumEntity.fromJson(x)));

String condominiumEntityToJson(List<CondominiumEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
    final List<TechnicalEntity> technical;
    // todo corregir:
    final List<dynamic> owner;
    final List<PaymentEntity> payment;
    final List<DepartmentEntity> department;
    final List<PayEntity> pay;
    final ManagerEntity manager;

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
        required this.owner,
        required this.payment,
        required this.department,
        required this.pay,
        required this.manager,
    });

    factory CondominiumEntity.fromJson(Map<String, dynamic> json) => CondominiumEntity(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        pantry: json["pantry"],
        image: json["image"],
        meterNumber: json["meter_number"],
        isActive: json["isActive"],
        numberOfApartments: json["number_of_apartments"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        technical: List<TechnicalEntity>.from(json["technical"].map((x) => TechnicalMapper.technicalJsonToEntity(x))),
        owner: List<dynamic>.from(json["owner"].map((x) => x)),
        payment: List<PaymentEntity>.from(json["payment"].map((x) => PaymentMapper.paymentJsonToEntity(x))),
        department: List<DepartmentEntity>.from(json["department"].map((x) => DepartmentMapper.departmentJsonToEntity(x))),
        pay: List<PayEntity>.from(json["pay"].map((x) => PayMapper.payJsonToEntity(x))),
        manager: ManagerMapper.managerJsonToEntity(json["manager"]),
    );

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
        "technical": List<dynamic>.from(technical.map((x) => x.toJson())),
        "owner": List<dynamic>.from(owner.map((x) => x)),
        "payment": List<dynamic>.from(payment.map((x) => x.toJson())),
        "department": List<dynamic>.from(department.map((x) => x.toJson())),
        "pay": List<dynamic>.from(pay.map((x) => x.toJson())),
        "manager": manager.toJson(),
    };
}
