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
  final DateTime updatedAt;
  final int typeUser;

  final Role role;
  final String token;

  UserEntity({
    required this.id,
    required this.fullname,
    required this.lastname,
    required this.email,
    this.phone,
    this.codeCountry,
    required this.gender,
    this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.typeUser,
    required this.role,
    required this.token,
  });
}

class Role {
  final String id;
  final String name;
  final String description;
  final bool isEnable;
  final DateTime createdAt;
  final DateTime updatedAt;

  Role({
    required this.id,
    required this.name,
    required this.description,
    required this.isEnable,
    required this.createdAt,
    required this.updatedAt,
  });
}
