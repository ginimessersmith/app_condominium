// To parse this JSON data, do
//
//     final userEntity = userEntityFromJson(jsonString);


import 'package:condominium/auth/domain/entities/role.entity.dart';
import 'package:condominium/pay/domain/domain_pay.dart';


class UserEntity {
  final String id;
  final String fullname;
  final String lastname;
  final String email;
  final int? phone;
  final int? codeCountry;
  final String gender;
  final String? photoUrl;
  final DateTime createdAt;
  final bool isEmailSend;
  final DateTime updatedAt;
  final int typeUser;
  final List<PayEntity> pay;
  final RoleEntity role;
  final String token;

  UserEntity({
    required this.id,
    required this.fullname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.codeCountry,
    required this.gender,
    required this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.typeUser,
    required this.pay,
    required this.role,
    required this.token,
    required this.isEmailSend,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "codeCountry": codeCountry,
        "gender": gender,
        "photoUrl": photoUrl,
        "isEmailSend": isEmailSend,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "type_user": typeUser,
        "pay": List<dynamic>.from(pay.map((x) => x.toJson())),
        "role": role.toJson(),
        "token": token,
      };
}
