import 'package:condominium/department/domain/entities/department.entity.dart';

class DepartmentMapper {
  static DepartmentEntity departmentJsonToEntity(Map<String, dynamic> json) => DepartmentEntity(
        id: json["id"],
        block: json["block"],
        floor: json["floor"],
        numberDepartment: json["number_department"],
        guestNumber: json["guest_number"],
        bedroomNumber: json["bedroom_number"],
        isActive: json["isActive"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );
}
