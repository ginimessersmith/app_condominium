import 'package:condominium/auth/domain/entities/user.entity.dart';
import 'package:condominium/auth/infrastructure/mappers/user.mapper.dart';
import 'package:condominium/condominium/domain/domain_condominium.dart';
import 'package:condominium/department/domain/domain_department.dart';
import 'package:condominium/pay/domain/domain_pay.dart';

class ManagerEntity {
    final List<CondominiumEntity> condominium;
    final List<DepartmentEntity> department;
    final List<PayEntity> pay;
    final String id;
    final String responsibility;
    final UserEntity user;

    ManagerEntity({
        required this.condominium,
        required this.department,
        required this.pay,
        required this.id,
        required this.responsibility,
        required this.user,
    });

    Map<String, dynamic> toJson() => {
        "condominium": List<dynamic>.from(condominium.map((x) => x)),
        "department": List<dynamic>.from(department.map((x) => x)),
        "pay": List<dynamic>.from(pay.map((x) => x)),
        "id": id,
        "responsibility": responsibility,
        "user": user.toJson(),
    };
}
