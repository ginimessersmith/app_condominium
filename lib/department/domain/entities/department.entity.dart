
class DepartmentEntity {
    final String id;
    final String block;
    final int floor;
    final int numberDepartment;
    final int guestNumber;
    final int bedroomNumber;
    final bool isActive;
    final DateTime createdAt;
    final DateTime updatedAt;

    DepartmentEntity({
        required this.id,
        required this.block,
        required this.floor,
        required this.numberDepartment,
        required this.guestNumber,
        required this.bedroomNumber,
        required this.isActive,
        required this.createdAt,
        required this.updatedAt,
    });

    

    Map<String, dynamic> toJson() => {
        "id": id,
        "block": block,
        "floor": floor,
        "number_department": numberDepartment,
        "guest_number": guestNumber,
        "bedroom_number": bedroomNumber,
        "isActive": isActive,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}



