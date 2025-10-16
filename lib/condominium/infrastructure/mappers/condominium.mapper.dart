import 'package:condominium/auth/domain/domain.dart';
import 'package:condominium/auth/infrastructure/infrastructure.dart';
import 'package:condominium/condominium/domain/domain_condominium.dart';
import 'package:condominium/department/domain/domain_department.dart';
import 'package:condominium/department/infrastructure/infrastructure_department.dart';

class CondominiumMapper {
  static CondominiumEntity condominiumJsonToEntity(Map<String, dynamic> json) =>
      CondominiumEntity(
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
        technical: json["technical"] != null
            ? List<TechnicalEntity>.from(json["technical"]
                .map((x) => TechnicalMapper.technicalJsonToEntity(x)))
            : null,
        manager: json["manager"] != null
            ? ManagerMapper.managerJsonToEntity(json["manager"])
            : null,
        department: json["department"] != null
            ? List<DepartmentEntity>.from(json["department"]
                .map((x) => DepartmentMapper.departmentJsonToEntity(x)))
            : null,
      );
}
