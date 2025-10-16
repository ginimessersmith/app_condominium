import 'package:condominium/auth/presentation/providers/auth_provider.dart';
import 'package:condominium/department/domain/repositories/department_repository.dart';
import 'package:condominium/department/infrastructure/infrastructure_department.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final departmentRepositoryProvider = Provider<DepartmentRepository>(
  (ref) {
    final token = ref.watch(authProvider).user?.token ?? '';
    final departmentRepository = DepartmentRepositoryImpl(
      datasource: DepartmentDatasourceImpl(accessToken: token),
    );
    return departmentRepository;
  },
);
