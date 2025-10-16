import 'package:condominium/department/domain/datasource/department_datasource.dart';
import 'package:condominium/department/domain/entities/department.entity.dart';
import 'package:condominium/department/domain/repositories/department_repository.dart';

class DepartmentRepositoryImpl extends DepartmentRepository {
  final DepartmentDatasource datasource;

  DepartmentRepositoryImpl({required this.datasource});
  @override
  Future<List<DepartmentEntity>> listDepartmentByUser() {
    // TODO: implement listDepartmentByUser
    return datasource.listDepartmentByUser();
  }

  @override
  Future<DepartmentEntity> findOneDepartment(String id) {
    // TODO: implement findOneDepartment
    return datasource.findOneDepartment(id);
  }
}
