import 'package:condominium/auth/domain/entities/manager.entity.dart';
import 'package:condominium/auth/infrastructure/mappers/user.mapper.dart';
import 'package:condominium/condominium/domain/domain_condominium.dart';
import 'package:condominium/department/domain/domain_department.dart';
import 'package:condominium/pay/domain/domain_pay.dart';

class ManagerMapper {
  static ManagerEntity managerJsonToEntity(Map<String, dynamic> json) =>
      ManagerEntity(
        condominium: List<CondominiumEntity>.from(json["condominium"].map((x) => x)),
        department: List<DepartmentEntity>.from(json["department"].map((x) => x)),
        pay: List<PayEntity>.from(json["pay"].map((x) => x)),
        id: json["id"],
        responsibility: json["responsibility"],
        user: UserMapper.userJsonToEntity(json["user"]),
      );
}
