import 'package:condominium/auth/domain/entities/technical.entity.dart';
import 'package:condominium/auth/infrastructure/mappers/user.mapper.dart';

class TechnicalMapper {
   static TechnicalEntity technicalJsonToEntity(Map<String, dynamic> json) => TechnicalEntity(
        id: json["id"],
        specialty: json["specialty"],
        contractDate: DateTime.parse(json["contract_date"]),
        user: UserMapper.userJsonToEntity(json["user"]),
    );
}

