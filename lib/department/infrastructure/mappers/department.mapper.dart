import 'package:condominium/condominium/infrastructure/mappers/condominium.mapper.dart';
import 'package:condominium/department/domain/entities/department.entity.dart';
import 'package:condominium/meter/domain/entities/meter.entity.dart';
import 'package:condominium/meter/infrastructure/mappers/meter.mapper.dart';
import 'package:condominium/pay/domain/domain_pay.dart';
import 'package:condominium/pay/infrastructure/infrastructure_pay.dart';

class DepartmentMapper {
  static DepartmentEntity departmentJsonToEntity(Map<String, dynamic> json) =>
      DepartmentEntity(
        id: json["id"],
        block: json["block"],
        floor: json["floor"],
        numberDepartment: json["number_department"],
        guestNumber: json["guest_number"],
        bedroomNumber: json["bedroom_number"],
        isActive: json["isActive"],
        condominium: json["condominium"] != null
            ? CondominiumMapper.condominiumJsonToEntity(json["condominium"])
            : null,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        meter: json["meter"] != null
            ? List<MeterEntity>.from(
                json["meter"].map((x) => MeterMapper.meterJsonToEntity(x)))
            : null,
        pay: json["pay"] != null
            ? List<PayEntity>.from(
                json["pay"].map((x) => PayMapper.payJsonToEntity(x)))
            : null,
      );
}
