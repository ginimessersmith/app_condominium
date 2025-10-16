import 'package:condominium/department/domain/domain_department.dart';

abstract class DepartmentRepository {
  Future<List<DepartmentEntity>> listDepartmentByUser();
  Future<DepartmentEntity> findOneDepartment(String id);
}
