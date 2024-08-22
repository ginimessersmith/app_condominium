class RoleEntity {
    final String id;
    final String name;
    final String description;
    final bool isEnable;
    final DateTime createdAt;
    final DateTime updatedAt;

    RoleEntity({
        required this.id,
        required this.name,
        required this.description,
        required this.isEnable,
        required this.createdAt,
        required this.updatedAt,
    });

    

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "isEnable": isEnable,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
