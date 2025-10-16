import 'package:condominium/auth/domain/domain.dart';
import 'package:condominium/auth/infrastructure/infrastructure.dart';
import 'package:condominium/pay/domain/domain_pay.dart';
import 'package:condominium/pay/infrastructure/infrastructure_pay.dart';

class UserMapper {
  static UserEntity userJsonToEntity(Map<String, dynamic> json) => UserEntity(
        id: json["id"],
        fullname: json["fullname"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        codeCountry: json["codeCountry"],
        isEmailSend: json["isEmailSend"],
        gender: json["gender"],
        photoUrl: json["photoUrl"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        typeUser: json["type_user"],
        pay: json["pay"] == null
            ? List<PayEntity>.from(
                json["pay"].map((x) => PayMapper.payJsonToEntity(x)))
            : [],
        role:RoleMapper.roleJsonToEntity(json["role"]),
        token: json["token"],
      );
}
