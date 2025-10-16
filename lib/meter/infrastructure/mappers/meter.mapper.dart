import 'package:condominium/department/infrastructure/infrastructure_department.dart';
import 'package:condominium/meter/domain/entities/meter.entity.dart';

class MeterMapper {
  static MeterEntity meterJsonToEntity(Map<String, dynamic> json) =>
      MeterEntity(
        id: json["id"],
        month: json["month"],
        isActive: json["isActive"],
        state: json["state"],
        year: json["year"],
        consummation: json["consummation"],
        imgUrl: json["img_url"],
        department: json["department"]!=null
        ?DepartmentMapper.departmentJsonToEntity(json["department"])
        :null,
        createAt: DateTime.parse(json["create_at"]),
        updateAt: DateTime.parse(json["update_at"]),
      );
}
