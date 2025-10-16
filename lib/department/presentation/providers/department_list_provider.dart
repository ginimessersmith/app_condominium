import 'package:condominium/department/domain/domain_department.dart';
import 'package:condominium/department/domain/repositories/department_repository.dart';
import 'package:condominium/department/presentation/providers/department_repository_provider.dart';
import 'package:condominium/shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final departmentByOwnerProvider = StateNotifierProvider<
    DepartmentByOwnerStateNotifier, DepartmentByOwnerState>((ref) {
  final departmentRepository = ref.watch(departmentRepositoryProvider);

  return DepartmentByOwnerStateNotifier(
      departmentRepository: departmentRepository);
});

class DepartmentByOwnerStateNotifier
    extends StateNotifier<DepartmentByOwnerState> {
  final DepartmentRepository departmentRepository;
  DepartmentByOwnerStateNotifier({required this.departmentRepository})
      : super(DepartmentByOwnerState());

  Future<void> listDepartment() async {
    if (state.isLoading) return;
    try {
      state = state.copyWith(isLoading: true);
      final list = await departmentRepository.listDepartmentByUser();
      state = state.copyWith(isLoading: false, listDepartment: list);
    } on CustomError catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.message,
      );
    } catch (e) {
      _setError('Error no implementado');
    }
  }

  _setError(String message) {
    state = state.copyWith(
      isLoading: false,
      errorMessage: message,
    );
  }
}

class DepartmentByOwnerState {
  final bool isLoading;
  final List<DepartmentEntity> listDepartment;
  final String errorMessage;

  DepartmentByOwnerState({
    this.isLoading = false,
    this.listDepartment = const [],
    this.errorMessage = '',
  });

  DepartmentByOwnerState copyWith({
    bool? isLoading,
    List<DepartmentEntity>? listDepartment,
    String? errorMessage,
  }) =>
      DepartmentByOwnerState(
          errorMessage: errorMessage ?? this.errorMessage,
          isLoading: isLoading ?? this.isLoading,
          listDepartment: listDepartment ?? this.listDepartment);
}
