import 'package:condominium/auth/domain/domain.dart';

class RoleMapper {
  static RoleEntity roleJsonToEntity(Map<String, dynamic> json) => RoleEntity(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        isEnable: json["isEnable"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );
}
