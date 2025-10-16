import 'package:condominium/department/domain/domain_department.dart';

abstract class DepartmentDatasource {
  Future<List<DepartmentEntity>> listDepartmentByUser();
  Future<DepartmentEntity> findOneDepartment(String id);
}
