import 'package:condominium/condominium/domain/domain_condominium.dart';
import 'package:condominium/condominium/presentation/providers/condominium_repository_provider.dart';
import 'package:condominium/shared/errors/custom_error.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final condominiumByTechProvider =
    StateNotifierProvider<CondominiumByTechNotifier, CondominiumByTechState>(
        (ref) {
  final condominiumRepo = ref.watch(condominiumRepositoyProvider);
  return CondominiumByTechNotifier(condominiumRepository: condominiumRepo);
});

class CondominiumByTechNotifier extends StateNotifier<CondominiumByTechState> {
  final CondominiumRepository condominiumRepository;
  CondominiumByTechNotifier({required this.condominiumRepository})
      : super(CondominiumByTechState());

  Future<void> loadCondominiumByTech() async {
    try {
      if (state.isLoading) return;
      state = state.copyWith(
        isLoading: true,
      );
      final condominiumByTech =
          await condominiumRepository.findCondominiunByTechnical();
      state = state.copyWith(
        isLoading: false,
        condominiumByTech: condominiumByTech,
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

class CondominiumByTechState {
  final bool isLoading;
  final CondominiumEntity? condominiumByTech;
  final String errorMessage;

  CondominiumByTechState({
    this.isLoading = false,
    this.condominiumByTech,
    this.errorMessage = '',
  });

  CondominiumByTechState copyWith(
          {bool? isLoading,
          CondominiumEntity? condominiumByTech,
          String? errorMessage}) =>
      CondominiumByTechState(
        isLoading: isLoading ?? this.isLoading,
        condominiumByTech: condominiumByTech ?? this.condominiumByTech,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
