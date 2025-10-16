import 'package:condominium/department/domain/domain_department.dart';
import 'package:condominium/department/domain/repositories/department_repository.dart';
import 'package:condominium/department/presentation/providers/department_repository_provider.dart';
import 'package:condominium/shared/errors/custom_error.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final oneDepartmentProvider = StateNotifierProvider.autoDispose
    .family<OneDepartmentNotifier, OneDepartmentState, String>(
        (ref, departmentId) {
  final departmentRepository = ref.watch(departmentRepositoryProvider);

  return OneDepartmentNotifier(
      departmentRepository: departmentRepository, id: departmentId);
});

class OneDepartmentNotifier extends StateNotifier<OneDepartmentState> {
  final DepartmentRepository departmentRepository;
  OneDepartmentNotifier(
      {required this.departmentRepository, required String id})
      : super(OneDepartmentState(id: id));

  Future<void> loadOneDepartment() async {
    try {
      if (state.isLoading) return;
      state = state.copyWith(isLoading: true);
      final department = await departmentRepository.findOneDepartment(state.id);
      state = state.copyWith(
        isLoading: false,
        department: department,
        errorMessage: '',
      );
    } on CustomError catch (e) {
      _setError(e.message);
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

class OneDepartmentState {
  final String id;
  final bool isLoading;
  final DepartmentEntity? department;
  final String errorMessage;

  OneDepartmentState(
      {required this.id,
      this.isLoading = false,
      this.department,
      this.errorMessage = ''});

  OneDepartmentState copyWith({
    String? id,
    bool? isLoading,
    DepartmentEntity? department,
    String? errorMessage,
  }) =>
      OneDepartmentState(
        id: id ?? this.id,
        isLoading: isLoading ?? this.isLoading,
        department: department ?? this.department,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
