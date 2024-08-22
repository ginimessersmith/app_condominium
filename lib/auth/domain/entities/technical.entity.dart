import 'package:condominium/auth/domain/entities/user.entity.dart';
import 'package:condominium/auth/infrastructure/mappers/user.mapper.dart';

class TechnicalEntity {
    final String id;
    final String specialty;
    final DateTime contractDate;
    final UserEntity user;

    TechnicalEntity({
        required this.id,
        required this.specialty,
        required this.contractDate,
        required this.user,
    });

    Map<String, dynamic> toJson() => {
        "id": id,
        "specialty": specialty,
        "contract_date": "${contractDate.year.toString().padLeft(4, '0')}-${contractDate.month.toString().padLeft(2, '0')}-${contractDate.day.toString().padLeft(2, '0')}",
        "user": user.toJson(),
    };
}
